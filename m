Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D788DDE06
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 01:40:14 +1000 (EST)
Date: Mon, 4 May 2009 17:40:01 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Need a patch tested on a windtunnel powermac
Message-ID: <20090504174001.5429769b@hyperion.delvare>
In-Reply-To: <20090504145232.GB14017@zod.rchland.ibm.com>
References: <18936.58163.872136.772820@cargo.ozlabs.ibm.com>
	<20090430002448.GA5208@hansolo.jdub.homelinux.org>
	<20090430191707.GB2424@yoda.jdub.homelinux.org>
	<20090504145232.GB14017@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh,

On Mon, 4 May 2009 10:52:32 -0400, Josh Boyer wrote:
> On Thu, Apr 30, 2009 at 03:17:08PM -0400, Josh Boyer wrote:
> >On Wed, Apr 29, 2009 at 08:24:48PM -0400, Josh Boyer wrote:
> >>On Thu, Apr 30, 2009 at 09:30:59AM +1000, Paul Mackerras wrote:
> >>>Does anyone here still have a "windtunnel" powermac (PowerMac3,6)
> >>>machine running Linux?  We need someone to test Jean Delvare's patch
> >>>to the therm_windtunnel driver.  The patch is at:
> >>>
> >>>http://patchwork.ozlabs.org/patch/26095/
> >>>
> >>>I don't have a windtunnel machine myself - I have a PowerMac3,5 but
> >>>not a PowerMac3,6.
> >>
> >>I might have one.  I'll pull the G4 I have out of it's box and check tomorrow.
> >
> >Amazingly enough, I do.  It's running some crusty-arse gentoo install from
> >2005, so I need to install something newer on it.  Hopefully that goes smoothly
> >today...
> 
> Ok, installed 2.6.30-rc4 plus Jean's patch and it appears to do something
> correctly:
> 
> [jwboyer@localhost macintosh]$ sudo modprobe therm_windtunnel
> [jwboyer@localhost macintosh]$ dmesg
> <snip>
> DS1775 digital thermometer [@49]
> Temp: 52.5 C  Hyst: 75.0 C  OS: 80.0 C
> ADM1030 fan controller [@2c]
> Reducing overheating limit to 65.0 C (Hyst: 60.0 C)
> CPU-temp: 52.9 C, Case: 31.3 C,  Fan: 0 (tuned -11)
> [jwboyer@localhost macintosh]$ uname -a
> Linux localhost.localdomain 2.6.30-rc4 #1 SMP Mon May 4 10:20:39 EDT 2009 ppc ppc ppc GNU/Linux

Thanks for testing and reporting. This completes the testing of all
macintosh thermal drivers.

For completeness, as I see you built the driver as a module, could you
try unloading and reloading it?

Thanks,
-- 
Jean Delvare
