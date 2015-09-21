Return-Path: <benh@kernel.crashing.org>
Message-ID: <1442871886.11901.15.camel@kernel.crashing.org>
Subject: Re: [Skiboot] Skiboot recovery of MCEs during MMIO read of SCOMs:
 55672ecfa21f
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Williams <patrick@stwcx.xyz>, Daniel Axtens <dja@axtens.net>
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 skiboot@lists.ozlabs.org
Date: Tue, 22 Sep 2015 07:44:46 +1000
In-Reply-To: <20150921200119.GD8884@asimov.ibm.com>
References: <1442804568.13852.9.camel@axtens.net>
 <20150921200119.GD8884@asimov.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 15:01 -0500, Patrick Williams wrote:
> On Mon, Sep 21, 2015 at 01:02:48PM +1000, Daniel Axtens wrote:
> > Hi,
> > 
> > This relates to 55672ecfa21f ("powerpc/book3s: Recover from MC in
> > sapphire on SCOM read via MMIO.").
> > 
> > According to that patch, some SCOM reads via MMIO could lead to a
> > Machine Check Error in skiboot. That patch provided kernel support for a
> > skiboot interface to recover from those MCEs.
> > 
> > That patch went into the kernel in Dec 2013. However, modern skiboot
> > does not expose the device tree property needed to use this mechanism.
> > As far as I can tell, nothing ever went into Skiboot for this purpose. 
> > 
> > Is this something we plan to use in the future? Or is it now redundant?
> > 
> > -- 
> > Regards,
> > Daniel
> > 
> > _______________________________________________
> > Skiboot mailing list
> > Skiboot@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/skiboot
> 
> XSCOM does not cause a machine check.  Centaur Inband SCOM does cause a
> machine check.  Was this maybe put in place in anticipation of
> supporting Inband SCOM?  Does skiboot support Inband SCOM now?

It doesn't yet but yes, the above is in anticipation for that support,
we needed the Linux side in long before we could actually roll the FW
side.

Cheers,
Ben.
