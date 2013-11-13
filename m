Return-Path: <scottwood@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B74AE2C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 12:54:52 +1100 (EST)
Message-ID: <1384307679.1403.122.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/4] phylib: Add Clause 45 read/write functions
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
Date: Tue, 12 Nov 2013 19:54:39 -0600
In-Reply-To: <ED492CCEAF882048BC2237DE806547C91512489F@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1384167864-2457-1-git-send-email-shh.xie@gmail.com>
 <1384293487.1403.67.camel@snotra.buserror.net>
 <ED492CCEAF882048BC2237DE806547C91512489F@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "shh.xie@gmail.com" <shh.xie@gmail.com>,
 Kanetkar Shruti-B44454 <Shruti@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Bucur Madalin-Cristian-B32716 <madalin.bucur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-11-12 at 19:51 -0600, Xie Shaohui-B21989 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, November 13, 2013 5:58 AM
> > To: shh.xie@gmail.com
> > Cc: linuxppc-dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Kanetkar
> > Shruti-B44454; Xie Shaohui-B21989; Bucur Madalin-Cristian-B32716
> > Subject: Re: [PATCH 1/4] phylib: Add Clause 45 read/write functions
> > 
> > On Mon, 2013-11-11 at 19:04 +0800, shh.xie@gmail.com wrote:
> > > From: Andy Fleming
> > >
> > > You need an extra parameter to read or write Clause 45 PHYs, so we
> > > need a different API with the extra parameter.
> > >
> > > Signed-off-by: Andy Fleming
> > > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > 
> > Why did you remove Andy's e-mail address?  Even though it's no longer valid, it
> > helps identify which specific person you're talking about.
> > 
> [S.H] Andy's e-mail address is not valid and git-send-mail will fail, I have to remove it to make git work.

Tell git send-email to not include that address, e.g. using
--suppress-cc, --no-signed-off-by-cc, --suppress-from, etc.

-Scott
