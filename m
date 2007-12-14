Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CD219DDF8D
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 19:06:42 +1100 (EST)
Date: Fri, 14 Dec 2007 02:12:10 -0600
From: Olof Johansson <olof@lixom.net>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
Message-ID: <20071214081210.GB27284@lixom.net>
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
	<Pine.LNX.4.62.0711271555520.5847@pademelon.sonytel.be>
	<20071127152317.GA5230@lixom.net>
	<Pine.LNX.4.62.0711281148020.27512@pademelon.sonytel.be>
	<Pine.LNX.4.62.0711291612290.24058@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.62.0711291612290.24058@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 29, 2007 at 04:13:14PM +0100, Geert Uytterhoeven wrote:
> On Wed, 28 Nov 2007, Geert Uytterhoeven wrote:
> > +static inline void warn_emulated_sysctl_register(void)
> > +{
> > +	int res = register_sysctl_table(warn_emulated_sysctl_root);
>         ^^^^^^^^^^
> > +	printk("@@@ register_sysctl_table() returned %d\n", res);
>         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +}
> 
> Woops, that part shouldn't have been there...

Care to resubmit a clean patch under a fresh subject? Paul didn't chime
in but hopefully he can pick it up for 2.6.25.


Thanks,

Olof
