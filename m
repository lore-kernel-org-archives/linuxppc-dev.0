Return-Path: <krypton@ulrich-teichert.org>
Received: from arbas.nms.ulrich-teichert.org (i3ED64DB1.versanet.de
	[62.214.77.177]) by ozlabs.org (Postfix) with ESMTP id 7F68D2BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 19:29:03 +1100 (EST)
Message-Id: <200501040820.j048K7hj002988@arbas.nms.ulrich-teichert.org>
To: mikemartin@linux.ca
Date: Tue, 4 Jan 2005 09:20:07 +0100 (MET)
In-Reply-To: <855e88d0050103200337efc719@mail.gmail.com> from "Mike Martin" at
	Jan 03, 2005 11:03:39 PM
From: Ulrich Teichert <krypton@ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, Philippe Guyot <pguyot@cvf.fr>
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

[del]
>Ok... trying again with Leigh Brown's boot image and a woody root
>floppy and a woody CD.
>
>The console capture is below. Leigh's kernel boots up great, asks for
>a root floppy and then ...
>
>VFS: Insert root floppy and press ENTER
>
>FAT: bogus logical sector size 1981
>FAT: bogus logical sector size 1981

Strange.

[del]
>Reiserfs? Huh? I tried it twice, two different floppies. Both written
>as follows (as suggested in Debian manual):
>sudo dd if=root.bin of=/dev/fd0 bs=1024 conv=sync ; sync
>\1440+0 records in
>1440+0 records out
>1474560 bytes transferred in 120.042950 seconds (12284 bytes/sec)

How did you format the floppys before?

>I can however boot the installation I made earlier using Leigh's
>image. I have completed the installation and it runs ... for a short
>period of time. After about 5 minutes or so it stops responding to the
>console and to pings.

Ugh. I would recommend to dd Leighs kernel to your disk then. This has been
running reliable for me. The bootup log looks good to me, minus the floppy issue,
it's very much like mine.

HTH,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Clé De Contact (Metal Urbain)
