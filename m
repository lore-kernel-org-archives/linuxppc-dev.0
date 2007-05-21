Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 09B4BDDE2B
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 02:04:45 +1000 (EST)
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1179506692.19188.2.camel@ld0161-tx32>
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
	<1179333421.7018.17.camel@ld0161-tx32>
	<b77c4b3dd22795a73cd32a0623722e51@kernel.crashing.org>
	<1179346653.8132.223.camel@rhino>
	<0c3907573f12a0731d03335fe3334363@kernel.crashing.org>
	<1179506692.19188.2.camel@ld0161-tx32>
Content-Type: text/plain
Date: Mon, 21 May 2007 09:04:44 -0700
Message-Id: <1179763484.8132.293.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-05-18 at 11:44 -0500, Jon Loeliger wrote:
> 
> And I haven't actually gotten it to work yet either...
> Am I missing something?  Like a CONFIG_ option beyond
> the RTC and CMOS variant that is necessary?
> 
> Dumbly,
> jdl
> 
> 

I wonder if you're running into the locked RTC problem on the m1575.
The version of u-boot that I'm using (recent pull from
opensource.freescale.com) has a workaround for that.  Can you verify if
this is the problem?

For the benefit of those who aren't aware of the problem, the RTC on the
m1575 is locked on boot until PCI memory space is read.

Maybe we should put the workaround in the kernel instead.  Any opinions?
