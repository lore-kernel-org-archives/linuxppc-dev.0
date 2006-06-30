Return-Path: <mgreer@mvista.com>
Date: Fri, 30 Jun 2006 11:27:54 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] todc: add support for Time-Of-Day-Clock
Message-ID: <20060630182754.GB10178@mag.az.mvista.com>
References: <20060628211320.GA13257@mag.az.mvista.com>
	<4CD92C09-A759-4B7C-9EC3-06E1C723D923@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CD92C09-A759-4B7C-9EC3-06E1C723D923@kernel.crashing.org>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Kim Phillips <Kim.Phillips@freescale.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 29, 2006 at 11:34:04PM -0500, Kumar Gala wrote:
> On Jun 28, 2006, at 4:13 PM, Mark A. Greer wrote:
> 
> >This is a resubmit with a proper subject and with all comments  
> >addressed.
> >Applies cleanly to powerpc.git  
> >649e85797259162f7fdc696420e7492f20226f2d
> >
> >Mark
> >--
> >
> >The todc code from arch/ppc supports many todc/rtc chips and is needed
> >in arch/powerpc.  This patch adds the todc code to arch/powerpc.
> >
> >Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> 
> Just noticed this and was wondering if you have looked at the new RTC  
> subsystem and if we can move any of this over to use that?

Yes, its on the todo list.  

> Kim has a patch for the MPC834x ITC board that appear to provide a  
> generic implementations of ppc_md.set_rtc_time, ppc.get_rtc_time  
> using the RTC class code.

I saw that but had a chance to really look at it yet.  Eventually, todc
should disappear.

Mark
