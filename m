Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id A1562B7080
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2010 03:38:44 +1100 (EST)
Date: Mon, 15 Feb 2010 17:38:30 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v3 02/11] powerpc/mpc5121: Add machine restart support
Message-ID: <20100215173830.7c19416c@wker>
In-Reply-To: <20100209232406.GA21807@pengutronix.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-3-git-send-email-agust@denx.de>
	<20100209232406.GA21807@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

On Wed, 10 Feb 2010 00:24:06 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> Two comments:
...
> > +void mpc512x_restart(char *cmd)
> > +{
> > +	struct mpc512x_reset_module *rm = reset_module_base;
> 
> Why not using reset_module_base directly?

I will fix it in v4 patch.

> > @@ -62,4 +95,5 @@ void __init mpc512x_init(void)
> >  {
> >  	mpc512x_declare_of_platform_devices();
> >  	mpc5121_clk_init();
> > +	mpc512x_restart_init();
> 
> If the return value is not checked here, you could as well make the function
> void. (Not much one could do in the error-case, too.)

Will fix it too, thanks!

Anatolij
