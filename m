Return-Path: <Bruce_Leonard@selinc.com>
In-Reply-To: <3D87E705-AB2F-490A-BD26-E9C6CE9E6749@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Who's the maintainer for the freescale MPC8349ITX board?
MIME-Version: 1.0
Message-ID: <OFEC14CD76.6DC877E0-ON88257267.0063D50C-88257267.0065FB8D@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 18 Jan 2007 10:33:55 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

Kumar Gala <galak@kernel.crashing.org> wrote on 01/17/2007 08:23:50 PM:
[...major snip...]
> 
> Well that's really odd than.  I'd try grabbing u-boot 1.2.0 and see 
> if you still have the same issue.

Do you mean u-boot 2.0 or did you really mean go backwards?  I've diffed 
ft_build.c between 1.1.6 and 2.0 and they're the same.

> 
> Also, how are you invoking dtc to get the dtb?

Originally is was using:
'dtc -I dts -O dtb mpc8349emitx.dts > 8349.blob'

Per Grant's suggestion I changed it to:
'dtc -I dts -O dtb -V 0x10 mpc8349emitx.dts > 8349.blob'

It changed the behavior but it still doesn't boot.  Something else I've 
observed that leads me to believe the *.dts is bad is that i have no 
output on the serial port once I jump to the kernel code.

Thanks for the suggestions, I'll keep digging.

Bruce
