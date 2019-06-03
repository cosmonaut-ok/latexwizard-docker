FROM debian:buster-slim
MAINTAINER Alexander Vynnyk <cosmonaut.ok@zoho.com>

RUN echo deb http://debian.org.ua/debian/ buster main contrib non-free >> /etc/apt/sources.list
RUN apt-get update
RUN echo "openjdk-11-jre shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections

# RUN apt-get -y install latexdraw writer2latex

RUN apt-get -y install texlive-full xfonts-cyrillic latex2html latex2rtf pandoc pandoc-citeproc pandoc-citeproc-preamble biber tex4ht latexml bibtex2html fonts-freefont-otf fonts-freefont-ttf ttf-mscorefonts-installer html2ps imagemagick  bibtexconv mediawiki2latex abntex csv2latex dblatex dot2tex foiltex gnuhtml2latex latex-fonts-sipa-arundina latex-make latex-mk latexdraw texstudio texstudio-l10n
# writer2latex

## install latex2wp for wordpress export
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN git clone https://github.com/cangiuli/latex2wp.git /tmp/latex2wp
RUN cd /tmp/latex2wp && stack build --copy-bins --local-bin-path=/usr/local/bin/
RUN mv /usr/local/bin/latex2wp-exe /usr/local/bin/latex2wp
RUN rm -rf /tmp/latex2wp

ENV DISPLAY :0
