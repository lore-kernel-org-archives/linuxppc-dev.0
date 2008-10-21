Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 349F6DDDE3
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 03:22:48 +1100 (EST)
Message-Id: <6963425B-36CF-4060-BA9E-AFAAD7728921@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0810210835t13564230wc83697034c0979a0@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Please pull from 'for-2.6.28' branch
Date: Tue, 21 Oct 2008 11:22:37 -0500
References: <Pine.LNX.4.64.0810201304160.17086@blarg.am.freescale.net>
	<20081020191731.GA26789@oksana.dev.rtsoft.ru>
	<76F4ACB5-204A-46F7-BE4F-069CA58114B3@kernel.crashing.org>
	<20081020204737.GA13189@oksana.dev.rtsoft.ru>
	<20081021144110.GA7249@oksana.dev.rtsoft.ru>
	<6A645055-3599-49DC-871C-2BC42199926F@kernel.crashing.org>
	<ed82fe3e0810210835t13564230wc83697034c0979a0@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 21, 2008, at 10:35 AM, Timur Tabi wrote:

> On Tue, Oct 21, 2008 at 9:49 AM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>> I understood, just haven't had time to look at these patches.  I  
>> don't know
>> if this is likely to make it into 2.6.28.
>
> I ack'd the QE library portions of these patches back in April.  Sure,
> a lot has changed since then, but what's the point of having a merge
> window if you don't actually merge the code?

The point is to attempt to get code merged.  There is only so much a  
maintainer can do during or before the window.  The fact that Ben had  
issues with the OF patch caused me to ignore this change until that  
got resolved.  Since that was resolved close to the merge window this  
particular set of patches suffered.

- k
