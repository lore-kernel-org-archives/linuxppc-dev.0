Return-Path: <lagrange@fr.oleane.com>
Received: from smtp02.msg.oleane.net (smtp02.msg.oleane.net [62.161.4.2])
	by ozlabs.org (Postfix) with ESMTP id 1516CDDE02
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 20:29:07 +1000 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: "'Gary Kenaley'" <gkenaley@echelon.com>,
	"'Bill Gatliff'" <bgat@billgatliff.com>
Subject: RE: Linux 2.6.x, MTD drivers and NAND flashes
Date: Tue, 12 Jun 2007 12:06:29 +0200
Message-ID: <000f01c7acd9$633bc290$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0010_01C7ACEA.26C70390"
In-Reply-To: <DDBD7B17DB2ECE48BCD94C593F7255B4046EA149@monk.echelon.echcorp.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C7ACEA.26C70390
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit


Gary and Bill,

My need is to load a basic Linux kernel on boards to program multiple 
NOR and NAND flashes with CRAMFS and JFFS2 (perhaps YAFFS) images.

I usually used mtd character accesses to do the job on NOR flashes.
But flash_eraseall and flashcp seem to be excellent tools.
I'll try them quickly.

Many thanks for your help
Bye
Laurent

> -----Message d'origine-----
> De : Gary Kenaley [mailto:gkenaley@echelon.com]
> Envoyé : lun. 11 juin 2007 21:00
> À : Bill Gatliff; Laurent Lagrange
> Cc : linuxppc-embedded@ozlabs.org
> Objet : RE: Linux 2.6.x, MTD drivers and NAND flashes
> 
> 
> Laurent,
> 
> Can't you just use the flashcp copy command from the 
> mtd-utils package?
> --------------------------------------------------------------
> ---------
> flash_eraseall -j /dev/mtd0
> 
> mkfs.jffs2 -b -n --eraseblock=131072 --pagesize=2048 -p -r 
> /test_root -v -o test_root.img
> 
> flashcp test_root.img /dev/mtd0
> 
> 
> The other way is what Bill mentions:
> ------------------------------------
> flash_eraseall -j /dev/mtd0
> mount -t jffs2 /dev/mtdblock0 /tmp/mnt
> tar -xzf test_root.tgz -C /tmp/mnt
> umount /tmp/mnt
> 
> Gary

------=_NextPart_000_0010_01C7ACEA.26C70390
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

eJ8+Ii8KAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEGgAMADgAAANcHBgAMAA0ABgAAAAIABQEB
A5AGAFwIAAAmAAAACwACAAEAAAALACMAAAAAAAMAJgAAAAAACwApAAAAAAADAC4AAAAAAAMANgAA
AAAAHgBwAAEAAAAqAAAATGludXggMi42LngsIE1URCBkcml2ZXJzIGFuZCBOQU5EIGZsYXNoZXMA
AAACAXEAAQAAABYAAAABx6zZWENFfnyuVVlEmr1a32Xt8YFlAAACAR0MAQAAABwAAABTTVRQOkxB
R1JBTkdFQEZSLk9MRUFORS5DT00ACwABDgAAAABAAAYOAJyfqOGsxwECAQoOAQAAABgAAAAAAAAA
gZyZ5cGUYkGPnwbftvVnDsKAAAADABQOAQAAAAsAHw4BAAAAAgEJEAEAAADPAwAAywMAAGoGAABM
WkZ11DzTBwMACgByY3BnMTI14jIDQ3RleAVBAQMB908KgAKkA+MCAGNoCsBz8GV0MCAHEwKAD/MA
UH8EVghVB7IRxQ5RAwEQxzL3BgAGwxHFMwRGEMkS2xHT2wjvCfc7GL8OMDURwgxgzmMAUAsJAWQz
NhFQC6ZLCuMKgEcKwHkgAHBkZCBCAxBsLB2UHZRNHR4gbgngHmAEACB0bwogGFBhHmBhIGJhCQ3R
IEwLgHV4IGv9BJFlAyACICDQIIALICAjBnADYAnAYW0gbXUkbHQFIGxlHYVOTwJSHjNOQU5EIGaZ
C2BzaAeRA/B0aBLAMFJBTUYF8B5CSkazJjAU4ChwBJAQ8HAEILRZQSaxKSAAAMBnB5CCLh7aSSB1
c3UHQP5sHiApUB/hDqAeYBDiANB3DrAFwADQYweQESAgI2THIFAlwCPQam9iIgIkUrMlJShlQnUF
QCUjXwSQvSDwZSmBHjMlIw3wIBEg9mUjQCBBYiPQDsArIB6gnwnwBUAgQAbwKFZJJy7BTnQeESvx
I0BxdQ3ga7spoChrTQBwMjIAcGsEICsCEAXAeQhhICVgbHDJLWV5ZR2UTGEIcDDB0R7aPiAtN7JN
KzEoIaUrsCcFsGlnC4BlN7OlNzZEI9A6IB3zSwnwdQdAZR4gWwDAAxAgQDp2ZyGgOqNABZA1MQIg
LgkFoG1dNzZFbnZv4HlcJ2U5OgEKQDxweCAxMSwgMrADoAHQMHI3PtAxOj7wNzY9oGNPEVA6EB6C
OiF0bAaQZt47ITA2dEFBIxFuKDA3Ng5DISA98SFScHBjLQsv0DAwZAEAZEBvei0LYGIoUAWwZzc2
T2JmahEwOgFSRToQIUQyoC42LngsBdBUJQD6ZAUQdgSQBCAknj+HSM3XNmUexUkYQwBwJwVANOF9
PoFzBUAp0SvjLzYFoHD/HiA8kQOBLxEDYSvjNzYqIX4tLdADEAQgCrAy0CghP/83O1FvUn9Tj1P0
UK83Ni4NkC1qIC8BAHYvKiHLP3hPFmsD0C5qASAL8Hs3oCxQLQOgN7AuYwJgb2Ey0D0xMzE/AFnR
LUMKsCgxaXplPQHQNLY4N6AvkC0K1DdyLw6wlUxwXwNgbwVALXY3oPsr0V2WLgdwRNdWGy+BXot7
V69JL1QsAV3wJWAFwHf2YR4gIBF3EPAFQEBzB4DlAjBpAiBzOlUPZw9Ub99Wj1efT2EIYDDRLQVA
WZTPamZawxFQXXBtcGHwNraHN5ABkAXALXh6Zl55qHRnejegQ21PdWt0L21eNzYd8h2UfXOQAB4A
QhABAAAARAAAADxEREJEN0IxN0RCMkVDRTQ4QkNEOTRDNTkzRjcyNTVCNDA0NkVBMTQ5QG1vbmsu
ZWNoZWxvbi5lY2hjb3JwLmNvbT4AAwAJWQEAAAALAACACCAGAAAAAADAAAAAAAAARgAAAAADhQAA
AAAAAAMAAoAIIAYAAAAAAMAAAAAAAABGAAAAABCFAAAAAAAAAwAPgAggBgAAAAAAwAAAAAAAAEYA
AAAAUoUAAHN5AQAeABCACCAGAAAAAADAAAAAAAAARgAAAABUhQAAAQAAAAQAAAA5LjAACwARgAgg
BgAAAAAAwAAAAAAAAEYAAAAABoUAAAAAAAADABKACCAGAAAAAADAAAAAAAAARgAAAAABhQAAAAAA
AAsAG4AIIAYAAAAAAMAAAAAAAABGAAAAAA6FAAAAAAAAAwAcgAggBgAAAAAAwAAAAAAAAEYAAAAA
EYUAAAAAAAADAB6ACCAGAAAAAADAAAAAAAAARgAAAAAYhQAAAAAAAAMAQIHLp3HGqdHLR4weyXjI
xp+UAQAAACYAAABFAG0AbwBuACAAUwBjAGEAbgBuAGUAcgAgAEIAdQBpAGwAZAAAAAAA2EoPAAIB
+A8BAAAAEAAAAIGcmeXBlGJBj58G37b1Zw4CAfoPAQAAABAAAACBnJnlwZRiQY+fBt+29WcOAgH7
DwEAAACNAAAAAAAAADihuxAF5RAaobsIACsqVsIAAG1zcHN0LmRsbAAAAAAATklUQfm/uAEAqgA3
2W4AAABDOlxEb2N1bWVudHMgYW5kIFNldHRpbmdzXGdlZ1xMb2NhbCBTZXR0aW5nc1xBcHBsaWNh
dGlvbiBEYXRhXE1pY3Jvc29mdFxPdXRsb29rXGxhbC5wc3QAAAAAAwD+DwUAAAADAA00/TcAAAIB
fwABAAAAMQAAADAwMDAwMDAwODE5Qzk5RTVDMTk0NjI0MThGOUYwNkRGQjZGNTY3MEVBNDgwMjYw
MAAAAAADAAYQf/6RhwMABxCCAwAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEdBUllBTkRC
SUxMLE1ZTkVFRElTVE9MT0FEQUJBU0lDTElOVVhLRVJORUxPTkJPQVJEU1RPUFJPR1JBTU1VTFRJ
UExFTk9SQU5ETkFOREZMQVNIRVNXSVRIQ1JBTUZTQU5ESkYAAAAAYR4=

------=_NextPart_000_0010_01C7ACEA.26C70390--
