From: erik.teose@exgate.tek.com
Message-ID: <BA0E4392AD99D040885C414D992C24BE0165DBE5@us-bv-m11>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: How do you change the program counter (PC)
Date: Fri, 24 Jan 2003 08:58:20 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > SREC: (I am not much sure) It seems an old format used
> mostly by motorola.
> > It's like BIN format, but has other information used for
> downloading. It seems
> > some bootloaders need SREC format for downloading.
> >
>
> SREC is more or less the same as a BIN file but it has an address and
> checksum so it would be much smaller if you want to put a
> byte at 0 and
> one at 100000 and you can be sure that is is correctly transfered.

A big difference is that SREC is full ascii, which means lots of
bytes of overhead, which means longer transfer times if you're loading
via rs232.

Erik

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
