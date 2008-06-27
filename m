Return-Path: <Monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id CF0CADDEEB
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 00:55:07 +1000 (EST)
In-Reply-To: <20080627115936.GA18644@cs181140183.pp.htv.fi>
Date: Fri, 27 Jun 2008 15:19:34 +0200 (CEST)
To: =?us-ascii?Q?Adrian=20Bunk?= <bunk@kernel.org>
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5BPATCH=2048=2F60=5D=20microblaze=5Fv4=3A=20headers=20simple=20files=20=2D=20empty=20or=20redirect=20to=20asm=2Dgeneric?=
Mime-Version: 1.0
Message-Id: <4641.7464-1541-432171441-1214572774@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii"
Cc: linux-arch@vger.kernel.org,
	=?us-ascii?Q?Michal=20Simek?= <monstr@monstr.eu>,
	=?us-ascii?Q?Arnd=20Bergmann?= <arnd@arndb.de>,
	vapier.adi@gmail.com, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, john.williams@petalogix.com,
	hpa@zytor.com, drepper@redhat.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Adrian and Arnd,

>> > After all, it won't matter whether we'll unify resp. remove
>> > 22 or 23 files.
>> 
>> That wasn't my idea. The logic was that if one more file exists
>> in asm-generic that can be removed from the architectures,
>> we get 22 more files to remove without anyone having to look
>> at the big picture. When microblaze is in,
>
>Discussions of the "big picture" should be in an own thread, not as 
>part of a merge of a new architecture.
>
>I am not an architecture maintainer, but I do not like the way you want 
>to couple the microblaze merge with the move of stuff to asm-generic.
>
>They both make sense, but they are clearly separate issues.
>
>> I can compile a list
>> with asm-generic files that can be used to replace the architecture
>> specific files, so the arch maintainers can decide on their own
>> whether to clean their own stuff up or not.
>>...
>
>We need either all architectures changed or none at all - we do need the 
>arch headers to become more similar, not more different.
>
>And this is why we need an agreement _before_ an asm-generic header gets 
>added, not after it.

I moved some headers to asm-generic how Arnd recommended to me. The same style
is applied to of files. If you think that is good idea to start with new topic what is necessary to move
to asm-generic, I agree. For me is not hard to move these files back to asm-microblaze and then
someone can do big patch among all archs.
If you want to managed, please open new discussion about and cc me.

Michal
