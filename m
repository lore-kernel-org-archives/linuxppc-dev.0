Return-Path: <sydneymartin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id D06742BF07
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 00:42:01 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so177987wra
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Jan 2005 05:41:57 -0800 (PST)
Message-ID: <855e88d005010405417d49dcfb@mail.gmail.com>
Date: Tue, 4 Jan 2005 08:41:56 -0500
From: Mike Martin <sydneymartin@gmail.com>
To: Philippe Guyot <pguyot@cvf.fr>
In-Reply-To: <855e88d005010403234bd3eeb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <20050101150055.GA15400@pegasos> <200501031530.54487.pguyot@cvf.fr>
	<855e88d0050103200337efc719@mail.gmail.com>
	<200501041023.37580.pguyot@cvf.fr>
	<855e88d005010403234bd3eeb3@mail.gmail.com>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
Reply-To: mikemartin@linux.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'll give 2.4.22 a try tonight.
> 
> Thanks!
> MikeMartin

I gave Leigh's 2.4.22 a try. It gave me the same result with the
debian root disk:

VFS: Insert root floppy and press ENTER

FAT: bogus logical sector size 1981
FAT: bogus logical sector size 1981
read_super_block: can't find a reiserfs filesystem on (dev 02:00,
block 64, size 1024)
read_super_block: can't find a reiserfs filesystem on (dev 02:00,
block 8, size 1024)
Kernel panic: VFS: Unable to mount root fs on 02:00

Tonight I'll grab a different root floppy and see what happens.

Leigh's 2.4.22 will also boot the system installed on /dev/sdb1,
however it also stopped responding after awhile. I think it lasted
longer than with 2.4.19.

MikeMartin
