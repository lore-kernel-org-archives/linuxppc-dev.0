From: phandel@cise.ufl.edu
Date: Sun, 23 Jan 2000 11:07:36 -0500 (EST)
To: Even André Fiskvik <even@lynweb.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Voodoo 3 ROM image
In-Reply-To: <B4B0CFE5.9%even@lynweb.net>
Message-ID: <Pine.LNX.4.21.0001231105001.9670-100000@adsl-78-160-189.gnv.bellsouth.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 23 Jan 2000, Even Andr[ISO-8859-1] é Fiskvik wrote:

> I have not tried the Voodoo X Server yet, but I know there is uploaded
> a other ROM image to the mac voodoo 3 cards, than in the PC voodoo 3 cards.
> What does the Voodoo X Server support, PC/MAC or both?

You'll need to flash it with the Macintosh ROM for it to work at all on
the Macintosh.

Kostas has released an experimental version of XFree86 3.9.16 that
supports the Voodoo3 accelerated:

ftp://idd-01.imbc.gr/pub/voodoo3/XFree3916-3.9.16-1.ppc.rpm
ftp://idd-01.imbc.gr/pub/voodoo3/vmlinux-991207.bz2

Known problems: if you switch to another console, you'll have artifacting
in X.


Thanks,
Peter

--
Peter F. Handel          "[The anti-Christ] also forced everyone, small and
phandel@cise.ufl.edu      great ... to receive a mark [smart card?] on his
www.cise.ufl.edu/~phandel right hand or on his forehead, so that no one could
FAX: (561) 619-8051       buy or sell unless he had the mark"-Revelation13:16

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
