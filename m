Return-Path: <SRS0+3550a31010a0b33b2856+1318+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: David Woodhouse <dwmw2@infradead.org>
To: michael@ellerman.id.au
In-Reply-To: <1175568133.16182.15.camel@concordia.ozlabs.ibm.com>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<26babf7b7398794f08e7417377b3facc@kernel.crashing.org>
	<1175473220.3144.1.camel@concordia.ozlabs.ibm.com>
	<432af8a0f928491e7d376923829f40a0@kernel.crashing.org>
	<1175568133.16182.15.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 02 Apr 2007 23:16:08 -0400
Message-Id: <1175570169.30552.3.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	cbe-oss-dev <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 12:42 +1000, Michael Ellerman wrote:
> My point was it's not coming out of the device tree, it's just
> manually lmb_add'ed.
> 
> > My question remains: shouldn't Linux get that
> > information from the device tree, instead?  The
> > bootwrapper or bootloader can put it there.
> 
> Yes it _should_, but it doesn't.

It _used_ to. The 2.6.16 kernel just used the memory listed in the
device tree. That's _why_ we need this hack -- because when we boot from
2.6.16 with the memory listed in the device tree, it ends up getting
registered twice by the new kernel.

-- 
dwmw2
