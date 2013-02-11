Return-Path: <baruch@tkos.co.il>
Received: from sivan.tkos.co.il (guitar.tcltek.co.il [192.115.133.116])
 by ozlabs.org (Postfix) with ESMTP id 808242C02B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 17:44:12 +1100 (EST)
Date: Mon, 11 Feb 2013 08:44:08 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [BUG] irq_dispose_mapping after irq request failure
Message-ID: <20130211064408.GC18462@sapphire.tkos.co.il>
References: <20130211053100.GB18462@sapphire.tkos.co.il>
 <20130211061949.GA5561@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130211061949.GA5561@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Mon, Feb 11, 2013 at 05:19:49PM +1100, Michael Ellerman wrote:
> On Mon, Feb 11, 2013 at 07:31:00AM +0200, Baruch Siach wrote:

[...]

> > mpc85xx_pci_err_probe: Unable to requiest irq 16 for MPC85xx PCI err
> While you're there, can you fix the typo :)

The patch fixing it is already queued at 
http://git.kernel.org/?p=linux/kernel/git/bp/bp.git;a=commitdiff;h=e7d2c215e56dc9fa0a01e26f2acfc3d73c889ba3.

Thanks for your details explanation. I'll now try to figure out what's wrong 
with my device tree.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
