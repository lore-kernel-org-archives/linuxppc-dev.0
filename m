Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53E402C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 11:26:10 +1000 (EST)
Message-ID: <1380158760.24959.240.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 3/3] powerpc/85xx: use one kernel option for all the
 CoreNet_Generic boards
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Wed, 25 Sep 2013 20:26:00 -0500
In-Reply-To: <20130926012310.GB9209@pek-khao-d1.corp.ad.wrs.com>
References: <1379991797-29222-1-git-send-email-haokexin@gmail.com>
 <1379991797-29222-4-git-send-email-haokexin@gmail.com>
 <1380062492.24959.123.camel@snotra.buserror.net>
 <20130925005843.GA20572@pek-khao-d1.corp.ad.wrs.com>
 <1380150683.24959.215.camel@snotra.buserror.net>
 <20130926012310.GB9209@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-26 at 09:23 +0800, Kevin Hao wrote:
> On Wed, Sep 25, 2013 at 06:11:23PM -0500, Scott Wood wrote:
> > On Wed, 2013-09-25 at 08:58 +0800, Kevin Hao wrote:
> > > On Tue, Sep 24, 2013 at 05:41:32PM -0500, Scott Wood wrote:
> > > > On Tue, 2013-09-24 at 11:03 +0800, Kevin Hao wrote:
> > > > > +	  and B4 QDS boards
> > > [...]
> > > > 
> > > > Is there any difference between the 32-bit and 64-bit versions of this
> > > > config symbol, other than the help text?
> > > 
> > > No. As you know some of these boards only support 32bit kernel and some of
> > > them only support 64bit kernel. It will definitely cause confusion when using
> > > only one kernel option for all these boards. So I divide this into two options
> > > (even the same name) for 32bit and 64bit respectively.
> > 
> > You could just mention in the help text which boards are 32-bit, which
> > are 64-bit, and which can work with either.
> 
> OK. How about this?
> 
>  arch/powerpc/platforms/85xx/Kconfig | 26 +++++++-------------------
>  1 file changed, 7 insertions(+), 19 deletions(-)

Looks good.

-Scott
