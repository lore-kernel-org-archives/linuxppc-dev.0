Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 868D52C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2014 13:47:57 +1100 (EST)
Message-ID: <1390531664.24905.640.camel@snotra.buserror.net>
Subject: Re: [PATCH] clk: corenet: Update the clock bindings
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>
Date: Thu, 23 Jan 2014 20:47:44 -0600
In-Reply-To: <ac1c6cb1a6e54f6e87b76e2a3006b64a@BL2PR03MB115.namprd03.prod.outlook.com>
References: <1390269732-22798-1-git-send-email-Yuantian.Tang@freescale.com>
 <1390437863.24905.549.camel@snotra.buserror.net>
 <d61cabaec0af4aada9fadf93e7c0bb61@BL2PR03MB115.namprd03.prod.outlook.com>
 <1390511008.24905.581.camel@snotra.buserror.net>
 <a0800d606e364b5980fe5c17efca9d9e@BL2PR03MB115.namprd03.prod.outlook.com>
 <1390530934.24905.639.camel@snotra.buserror.net>
 <ac1c6cb1a6e54f6e87b76e2a3006b64a@BL2PR03MB115.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-23 at 20:46 -0600, Tang Yuantian-B29983 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: 2014年1月24日 星期五 10:36
> > To: Tang Yuantian-B29983
> > Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org;
> > devicetree@vger.kernel.org; Kushwaha Prabhakar-B32579
> > Subject: Re: [PATCH] clk: corenet: Update the clock bindings
> > 
> > On Thu, 2014-01-23 at 20:33 -0600, Tang Yuantian-B29983 wrote:
> > > > > > Instead, how about a note like this near the top of the file:
> > > > > >
> > > > > > All references to "1.0" and "2.0" refer to the QorIQ chassis
> > > > > > version to which the chip complies.
> > > > > >
> > > > > > Chassis Version		Example Chips
> > > > > > ---------------		-------------
> > > > > > 1.0			p4080, p5020, p5040
> > > > > > 2.0			t4240, b4860, t1040
> > > > > >
> > > > > Better, I will update.
> > > > >
> > > > > >
> > > > > > BTW, this binding and the associated driver really should be
> > > > > > called "qoriq-clock", not "corenet-clock".  This would match the
> > > > > > compatible string, and it doesn't really have much to do with
> > > > > > corenet (which is part of the QorIQ chassis v1 and v2, but not
> > > > > > *this* part).  Do you know if the chassis v3 clock interface
> > > > > > will be similar enough to
> > > > share a driver?
> > > > > >
> > > > > Doesn't QorIQ include some low-end socs, like p1022, p1020?
> > > >
> > > > Yes, but those aren't "QorIQ Chassis 1.0" or "QorIQ Chassis 2.0".
> > > > They're mpc85xx-family chips.
> > > >
> > > > In any case, if "qoriq" makes sense for the compatible, I don't see
> > > > why it doesn't make sense for the driver.
> > > >
> > > So, "Corenet" is appropriate for driver.
> > > If something should change, that must be compatible string.
> > 
> > No.  Corenet is a bus interconnect, not a chip family (despite abuse of
> > the name in other contexts in Linux/U-Boot).  And the binding with qoriq
> > has already been accepted.
> > 
> QorIQ is not the best name either since it include the low-end socs.
> What the name should be? 

Again, those low-end chips do not implement "QorIQ Chassis 1.0" or
"QorIQ Chassis 2.0".  That they have "QorIQ" in their name is
irrelevant.

-Scott
