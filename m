Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 62C3868110
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Sep 2005 12:15:38 +1000 (EST)
Date: Mon, 5 Sep 2005 19:15:35 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: viro@ZenIV.linux.org.uk
Message-ID: <20050906021535.GA5512@gate.ebshome.net>
References: <20050906004423.GO5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050906004423.GO5155@ZenIV.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missed s/u32/pm_message_t/ in arch/ppc/syslib/ocp.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 06, 2005 at 01:44:23AM +0100, viro@ZenIV.linux.org.uk wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ----
> diff -urN RC13-git5-mga/arch/ppc/syslib/ocp.c RC13-git5-ppc44x-pm/arch/ppc/syslib/ocp.c
> --- RC13-git5-mga/arch/ppc/syslib/ocp.c	2005-08-28 23:09:40.000000000 -0400
> +++ RC13-git5-ppc44x-pm/arch/ppc/syslib/ocp.c	2005-09-05 16:41:17.000000000 -0400
> @@ -165,7 +165,7 @@
>  }
>  
>  static int
> -ocp_device_suspend(struct device *dev, u32 state)
> +ocp_device_suspend(struct device *dev, pm_message_t state)
>  {
>  	struct ocp_device *ocp_dev = to_ocp_dev(dev);
>  	struct ocp_driver *ocp_drv = to_ocp_drv(dev->driver);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Identical fix is already in -mm
