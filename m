Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4678BDE10E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Mar 2008 12:47:47 +1100 (EST)
Date: Fri, 29 Feb 2008 20:48:12 -0500
To: Wolfgang Denk <wd@denx.de>
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Sequoia build with KDBG
In-Reply-To: <20080301001632.BA47B2476B@gemini.denx.de>
References: <Your message of "Fri,
	29 Feb 2008 17:31:10 EST." <20080229223046.1B332DDE0A@ozlabs.org>
	<20080301001632.BA47B2476B@gemini.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080301014748.4678BDE10E@ozlabs.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

At 07:16 PM 2/29/2008, Wolfgang Denk wrote:
>In message <20080229223046.1B332DDE0A@ozlabs.org> you wrote:
> >
> > I assumed that because I've always needed a debugger when
> > implementing kernel level components. Since you've implemented kernel
> > level support for several 44x processors, I just assumed that you
> > needed kdbg at some point. So you're saying that your additions
> > worked right out of the gate and you never needed a 
> debugger?  You're my hero!
>
>Many people working on this stuff use a BDI2000 / BDI3000. Makes life
>much easier...

Wolfgang, you hit the nail on the head. Trying to debug a target 
without a JTAG debugger is a pain.
