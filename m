Return-Path: <hollis@penguinppc.org>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EC3122BF0E
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 02:49:41 +1100 (EST)
Received: from e33.co.us.ibm.com (e33.esmtp.ibm.com [9.14.4.131])
	by pokfb.esmtp.ibm.com (8.12.10/8.12.10) with ESMTP id j05FjQjK019504
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Jan 2005 10:45:26 -0500
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j05FjGCO686844
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Jan 2005 10:45:17 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j05FjGQn147388
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Jan 2005 08:45:16 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j05FjFfI013141
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Jan 2005 08:45:15 -0700
In-Reply-To: <20050105114719.GB14332@pegasos>
References: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
	<33151.82.10.231.190.1104878355.squirrel@82.10.231.190>
	<20050105090318.GA12317@pegasos> <200501051049.19225.pguyot@cvf.fr>
	<20050105114719.GB14332@pegasos>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <C9ACD772-5F30-11D9-A2C3-000A95A0560C@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Wed, 5 Jan 2005 09:45:13 -0600
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	mikemartin@linux.ca, debian-powerpc@lists.debian.org,
	Philippe Guyot <pguyot@cvf.fr>
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jan 5, 2005, at 5:47 AM, Sven Luther wrote:

> On Wed, Jan 05, 2005 at 10:49:19AM +0100, Philippe Guyot wrote:
>>> BTW, i have another question. I am trying to fix debian-installer to 
>>> create
>>> the prep partition, but i would like to have some info on the 
>>> expected
>>> constraints of said partition. Some tell it has to be entirely in 
>>> the first
>>> 8MB, others the first 5MB, and my powerstack has a 17MB boot 
>>> partition
>>> right now.
>>
>> All I can say, it's that my boot PReP partition is the 1st and about 
>> 4 MB in
>> size (cannot size it less than 1% of the disk.....)
>> second partition is /
>> third is swap.
>
> BTW, for debian, it makes more sense to have the second partition as 
> swap, and
> the third as /, i think, since it was decided some time back to 
> default to
> root=/dev/sda3, and not sda2.
>
>> That works for me.
>
> Until the kernel grows beyond 4MB.

The size of that partition depends on firmware limitations. I have 
definitely seen reports of systems not booting when the PReP boot 
partition was too large. I think on some systems that has even happened 
at 8MB.

In other words, should you need more space than 4-5MB at some point in 
the future, you cannot simply make a bigger boot partition.

-Hollis
