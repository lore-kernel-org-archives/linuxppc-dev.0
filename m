Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7DEF1DDFB9
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 02:09:28 +1000 (EST)
In-Reply-To: <200706291805.42528.arnd@arndb.de>
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<200706291545.53890.arnd@arndb.de>
	<5921DF9C-31D0-4805-B699-4E634DAA2FB4@kernel.crashing.org>
	<200706291805.42528.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E7FC1ABE-2482-48BD-9950-17C4DBC1811D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Fri, 29 Jun 2007 11:09:28 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 29, 2007, at 11:05 AM, Arnd Bergmann wrote:

> On Friday 29 June 2007, Kumar Gala wrote:
>>> Would it work reliably if we switch the arguments to
>>> '-mcpu=powerpc64 -m64' instead of '-m64 -mcpu=powerpc64'? That
>>> might be better than taking it out entirely.
>>
>> Is there a reason you didn't use -mcpu=power3 and -mcpu=rs64 for
>> those to CPU options?
>
> Not an important one. From looking at gcc source, it seemed to
> me that power3, rs64 and powerpc64 all specify the same instruction
> set, so I went for the most generic one.
>
> I guess we could always pass -mcpu=power3 instead of -mcpu=powerpc64
> if that solves the problem.

It did for me, the issue is you can still get an -mcpu=powerpc64 for  
iseries via:

+	default "-mcpu=powerpc64" if PPC64

- k
