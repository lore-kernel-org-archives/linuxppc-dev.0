In-Reply-To: <20040426190138.4392EC109F@atlas.denx.de>
Subject: Re: libjpeg
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF2F145C49.BE0B4823-ON85256E82.007533AB-85256E82.00754FEC@nanometrics.ca>
From: David Ho <DavidHo@nanometrics.ca>
Date: Mon, 26 Apr 2004 17:21:21 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Is there an idiot's guide to run the configure script to generate a
>
> "configure --help" may help ;-)
>
> > makefile that uses a cross-compiler instead of the native gcc.  I like
to
> > build it from my ix86 box.  I'm getting a headache from googling...
>

This seems to do the trick.

CC=ppc-linux-gcc ./configure --disable-shared ppc-linux
--prefix=/home/davidho/usr/local

David


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
