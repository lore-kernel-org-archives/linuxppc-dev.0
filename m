Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp2.wanadoo.fr (smtp2.wanadoo.fr [193.252.22.29])
	by ozlabs.org (Postfix) with ESMTP id 5A2E22BF0E
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 22:38:54 +1100 (EST)
Date: Wed, 5 Jan 2005 12:47:19 +0100
To: Philippe Guyot <pguyot@cvf.fr>
Message-ID: <20050105114719.GB14332@pegasos>
References: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
	<33151.82.10.231.190.1104878355.squirrel@82.10.231.190>
	<20050105090318.GA12317@pegasos> <200501051049.19225.pguyot@cvf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200501051049.19225.pguyot@cvf.fr>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, mikemartin@linux.ca
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 05, 2005 at 10:49:19AM +0100, Philippe Guyot wrote:
> > BTW, i have another question. I am trying to fix debian-installer to create
> > the prep partition, but i would like to have some info on the expected
> > constraints of said partition. Some tell it has to be entirely in the first
> > 8MB, others the first 5MB, and my powerstack has a 17MB boot partition
> > right now.
> 
> 
> All I can say, it's that my boot PReP partition is the 1st and about 4 MB in 
> size (cannot size it less than 1% of the disk.....)
> second partition is /
> third is swap.

BTW, for debian, it makes more sense to have the second partition as swap, and
the third as /, i think, since it was decided some time back to default to
root=/dev/sda3, and not sda2.

> That works for me.

Until the kernel grows beyond 4MB.

Friendly,

Sven Luther
