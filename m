Message-ID: <A1C99F4731CAD111BA5400A024FC3B0CBE046E@ESBILMA01EDCGE>
From: "Billalabeitia, Jose Carlos (IndSys, GEPM)" <jc.billalabeitia@indsys.ge.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Formatting JFFS2 Flash
Date: Thu, 14 Mar 2002 03:13:53 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Alex:

First of all, thank you for your answer. You wrote:

> Did you initialise the FS with
> cat jffs2.image > /dev/mtd0
> before you tried to mount /mtdblock0 ?

	I tried it in two ways, and in both of them
I got the same result:

	1.- By flashing "jffs2.image" directly to
	    its location address.

	2.- cp jffs2.image /dev/mtd0

and then mounting it into the system.

> Did you use an empty directory with mkfs.jffs2
> to make your jffs2.image?  This doesn't work
> - you end up with a 0 length jffs2.image!

	No, the directory is not empty.

					Thank you
						Billa


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
