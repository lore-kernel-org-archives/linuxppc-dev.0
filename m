Subject: Re: Where to find the library optimizer ?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Date: Mon, 13 Aug 2001 11:21:05 +0200
Message-ID: <566C53CBBECCFF4D8D31B380F7B345FB016646@PICARD.nc1701.de>
From: "Frank Przybylski" <fp@vas-gmbh.de>
To: "Lin, Nan-Hung" <carl@fiberlogic.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Lin, Nan-Hung!

> Where could I find a library optimizer to strip-out
> the unneeded codes from the library files ?

Have a try with 'mklibs.sh', which is included in the debian
 boot-floppies source package and has been mentioned earlier on this
list and on
http://penguinppc.org/usr/embedded/howto/PowerPC-Embedded-HOWTO-12.html
.

(e.g. for me in Germany I can downlod 'mklibs' at
http://ftp.de.debian.org/debian/dists/potato/main/source/admin/
where I can find 'boot-floppies_2.2.23.tar.gz', and there under
scripts/rootdisk/mklibs.sh ..)

hth
 Frank

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
