Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 9DA9FB6F10
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 18:12:33 +1100 (EST)
Received: by ewy2 with SMTP id 2so240760ewy.15
	for <linuxppc-dev@ozlabs.org>; Thu, 07 Oct 2010 00:12:32 -0700 (PDT)
Date: Thu, 7 Oct 2010 11:12:26 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] edac: mpc85xx: Add support for new MPCxxx/Pxxxx EDAC
	controllers (fix)
Message-ID: <20101007071226.GA32189@oksana.dev.rtsoft.ru>
References: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
	<20100716151224.21d499a3@schlenkerla.am.freescale.net>
	<20100721153933.64d02086.akpm@linux-foundation.org>
	<20100721182108.5a22c822@schlenkerla.am.freescale.net>
	<20100801105419.GA352@oksana.dev.rtsoft.ru>
	<5628792F-9A5F-4200-90B3-FB3939F02969@kernel.crashing.org>
	<20101007062909.GA27110@oksana.dev.rtsoft.ru>
	<0778A3B9-E242-4BCC-B318-154BE9ECB2C6@kernel.crashing.org>
	<4A00FECC-3840-45E1-AB2A-6BDBD0FE09E0@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4A00FECC-3840-45E1-AB2A-6BDBD0FE09E0@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, Peter Tyser <ptyser@xes-inc.com>,
	Doug Thompson <dougthompson@xmission.com>,
	Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 07, 2010 at 02:00:50AM -0500, Kumar Gala wrote:
> 
> On Oct 7, 2010, at 1:37 AM, Kumar Gala wrote:
> 
> >> @ -1125,7 +1128,10 @@ static struct of_device_id mpc85xx_mc_err_of_match[] = {
> >> 	{ .compatible = "fsl,mpc8569-memory-controller", },
> >> 	{ .compatible = "fsl,mpc8572-memory-controller", },
> >> 	{ .compatible = "fsl,mpc8349-memory-controller", },
> >> +	{ .compatible = "fsl,p1020-memory-controller", },
> >> +	{ .compatible = "fsl,p1021-memory-controller", },
> >> 	{ .compatible = "fsl,p2020-memory-controller", },
> >> +	{ .compatible = "fsl,p4080-memory-controller", },
> > 
> > This line should be here ;)
> 
> should NOT be here.

Hm. Are you sure? I thought that only L2 cache controller is
not applicable (and based on Scott's comment I removed
the l2 cache compatible entry for p4080). But I guess
memory-controller is somewhat similar to all other 85xx?

If it's not, I can surely prepare a patch that removes
p4080 entry.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
