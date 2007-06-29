Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 04461DDF98
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 00:44:22 +1000 (EST)
In-Reply-To: <200706291545.53890.arnd@arndb.de>
References: <Pine.LNX.4.64.0706290023590.15748@blarg.am.freescale.net>
	<18052.42546.78964.805791@cargo.ozlabs.ibm.com>
	<200706291545.53890.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5921DF9C-31D0-4805-B699-4E634DAA2FB4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Fri, 29 Jun 2007 09:44:23 -0500
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


On Jun 29, 2007, at 8:45 AM, Arnd Bergmann wrote:

> On Friday 29 June 2007, Paul Mackerras wrote:
>> It turns out that with Arnd's patches we now get "-mcpu=powerpc64" on
>> the command line, and that means that gcc *doesn't* put "-mppc64" the
>> as command line, and as barfs on the 64-bit instructions.  That's
>> presumably a gcc bug, but we'll have to work around it.  I think the
>> best thing is just to not put the -mcpu=powerpc64 in CFLAGS when no
>> specific CPU is selected.
>
> I can't reproduce the problem here unfortunately. My idea was to  
> always
> pass _some_ -mcpu= flag, in order to make sure it does not use
> an inappropriate default, e.g. when the compiler is built for a  
> default
> for power4 but you actually want to build a power3 kernel.
>
> Would it work reliably if we switch the arguments to
> '-mcpu=powerpc64 -m64' instead of '-m64 -mcpu=powerpc64'? That
> might be better than taking it out entirely.

Is there a reason you didn't use -mcpu=power3 and -mcpu=rs64 for  
those to CPU options?

- k
