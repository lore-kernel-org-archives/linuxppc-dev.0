Return-Path: <krypton@ulrich-teichert.org>
Received: from arbas.nms.ulrich-teichert.org (i3ED64C85.versanet.de
	[62.214.76.133]) by ozlabs.org (Postfix) with ESMTP id BBFCA2BDB5
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 02:27:06 +1100 (EST)
Message-Id: <200501041523.j04FNoO0009594@arbas.nms.ulrich-teichert.org>
To: mikemartin@linux.ca
Date: Tue, 4 Jan 2005 16:23:50 +0100 (MET)
In-Reply-To: <855e88d005010405417d49dcfb@mail.gmail.com> from "Mike Martin" at
	Jan 04, 2005 08:41:56 AM
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

>I gave Leigh's 2.4.22 a try. It gave me the same result with the
>debian root disk:
>
>VFS: Insert root floppy and press ENTER
>
>FAT: bogus logical sector size 1981
>FAT: bogus logical sector size 1981
>read_super_block: can't find a reiserfs filesystem on (dev 02:00,
>block 64, size 1024)
>read_super_block: can't find a reiserfs filesystem on (dev 02:00,
>block 8, size 1024)
>Kernel panic: VFS: Unable to mount root fs on 02:00

Could you try to format them before dd'ing on them, like fdformat /dev/fd0h1440?
I am not sure if that will change anything, though.

>Tonight I'll grab a different root floppy and see what happens.
>
>Leigh's 2.4.22 will also boot the system installed on /dev/sdb1,
>however it also stopped responding after awhile. I think it lasted
>longer than with 2.4.19.

I am begining to believe that there is some sort of hardware problem with your
box or it is an upgraded version which was a -140 in it's previous life, but my
-140 is rock solid with Leigh's 2.4.19 kernel - once it's up, that is.
I will leave it running tonight to see what happens,

HTH,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Clé De Contact (Metal Urbain)
