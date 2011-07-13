Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 13 Jul 2011 10:42:12 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] 4xx: Add check_link to struct ppc4xx_pciex_hwops
Message-ID: <20110713004212.GG20597@ozlabs.org>
References: <20110701064424.GE13483@ozlabs.org>
	<20110712174007.GA26664@crust.elkhashab.com>
	<20110712180404.GC4203@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110712180404.GC4203@zod.rchland.ibm.com>
Cc: Ayman El-Khashab <ayman@elkhashab.com>,
	LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 12, 2011 at 02:04:04PM -0400, Josh Boyer wrote:
> On Tue, Jul 12, 2011 at 12:40:07PM -0500, Ayman El-Khashab wrote:
> >On Fri, Jul 01, 2011 at 04:44:24PM +1000, Tony Breeds wrote:
> >> All current pcie controllers unconditionally use SDR to check the link and
> >> poll for reset.
> >
> >I was able to apply this patch and then modify the 460SX to
> >work correctly, so I think it is fine.  There is only 1
> >comment below.  So how does one supply a patch atop another
> >patch?
> >
> >Best,
> >Ayman
> >
> >> +static int __init ppc4xx_pciex_port_reset_sdr(struct ppc4xx_pciex_port *port)
> >> +{
> >> +	printk(KERN_INFO "PCIE%d: Checking link...\n",
> >> +	       port->index);
> >
> >Its not a functional problem, but this printk belongs in the
> >check link if anywhere rather than the reset.
> 
> I've got this queued in my tree locally.  I can make that change before
> I push it out.

Thanks Josh.  I really thought I'd fixed that before posting.

Yours Tony
