FROM python:3.9
ENV PORT=8000
COPY requirements.txt .

RUN wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz && \
    tar -xvzf ta-lib-0.4.0-src.tar.gz && \
    cd ta-lib/ && \
    ./configure --prefix=/usr && \
    make && \
    make install
RUN pip install TA-Lib
RUN rm -R ta-lib ta-lib-0.4.0-src.tar.gz

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt


WORKDIR /src
COPY /src /src

EXPOSE ${PORT}

CMD mercury run 0.0.0.0:$PORT