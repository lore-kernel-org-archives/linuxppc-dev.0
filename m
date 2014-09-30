Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0118.outbound.protection.outlook.com [157.56.110.118])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C23D1A03CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 06:17:23 +1000 (EST)
Message-ID: <1412108227.13320.309.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/fsl: Add support for pci(e) machine check
 exception on E500MC / E5500
From: Scott Wood <scottwood@freescale.com>
To: Jojy Varghese <jojyv@juniper.net>
Date: Tue, 30 Sep 2014 15:17:07 -0500
In-Reply-To: <D0505C72.10E3B%jojyv@juniper.net>
References: <D0505C72.10E3B%jojyv@juniper.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "hongtao.jia@freescale.com" <hongtao.jia@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Guenter Roeck <groeck@juniper.net>, Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-09-30 at 20:15 +0000, Jojy Varghese wrote:
> 
> On 9/30/14 8:50 AM, "Guenter Roeck" <linux@roeck-us.net> wrote:
> 
> >On Mon, Sep 29, 2014 at 06:31:06PM -0500, Scott Wood wrote:
> >> Which specific chip and revision did you see this on?  What is the value
> >> in MCSR?
> >> 
> >Jojy can answer that, at least for P5020. We have seen it on P5040 as
> >well,
> >though, so it is not just limited to one chip/revision.
> 
> The specifics are:
> PVR: 0x80240012
> Instruction that causes the MC exception: lwbrx
> 	The faulty load address is also present in RB. So we could change the
> logic to use that 
> instead of DEAR. What I don’t know is of there are other cases also which
> escapes the current logic.

Could you find out what MCSR was when that happened?  I'm most
interested in whether MAV was set, but the other bits would be
interesting as well.

-Scott
