Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <36127.200.163.11.85.1087915987.squirrel@popmail3.pop.com.br>
In-Reply-To: <20040614153728.13AD1C13D3@atlas.denx.de>
References: Your message of "Mon, 14 Jun 2004 07:47:33 PDT."           
    <005801c4521e$86e0ea40$26c8a8c0@GMAN>
    <20040614153728.13AD1C13D3@atlas.denx.de>
Date: Tue, 22 Jun 2004 11:53:07 -0300 (BRT)
Subject: Re: Lite5200 from RS232 to RS485
From: "Sauro Salomoni" <saurosalomoni@pop.com.br>
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I'm having quite a problem getting into the serial...

Searching through local files, I could see that, although using 2 or 3 chained
functions to get/set the serial status, it is (in fact) done with a readb/writeb
statement (or inb/outb). Is that correct?

So, in order to make a very small driver, that just access the serial port and
doesn't use other features (we need a very "clean" one here..), wich headers should
I include? Is <asm/io.h> just enough?
I tried to use as few headers as possible, but then I get the problem that the
readb/writeb functions are not defined...
Could anyone give me a helping hand?

Thanks.

Sauro Salomoni

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
