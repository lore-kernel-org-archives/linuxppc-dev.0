Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f21.google.com (mail-ew0-f21.google.com
	[209.85.219.21]) by ozlabs.org (Postfix) with ESMTP id AF2E5DDF16
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Feb 2009 23:27:44 +1100 (EST)
Received: by ewy14 with SMTP id 14so3055846ewy.9
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Feb 2009 04:27:42 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: "Reynes Philippe" <philippe.reynes@isismpp.fr>
Subject: Re: [PATCH] add gpio to mpc837X rdb
References: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
	<20090129192031.GA17060@oksana.dev.rtsoft.ru>
	<0819EFA5-E86A-4D7F-8C60-06721B8072D8@freescale.com>
	<761F451C5F17F74DAEE4661DA5ABBC1616C455@factorix.ISISTHIBAUD.local>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 02 Feb 2009 13:27:39 +0100
In-Reply-To: <761F451C5F17F74DAEE4661DA5ABBC1616C455@factorix.ISISTHIBAUD.local>
	(Reynes Philippe's message of "Mon\, 2 Feb 2009 10\:13\:51 +0100")
Message-ID: <877i49gh1g.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Reynes" == Reynes Philippe <philippe.reynes@isismpp.fr> writes:

 Reynes> Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
 Reynes> ---
 Reynes> Index: powerpc/arch/powerpc/boot/dts/mpc8377_rdb.dts
 Reynes> ===================================================================
 Reynes> --- powerpc.orig/arch/powerpc/boot/dts/mpc8377_rdb.dts
 Reynes> +++ powerpc/arch/powerpc/boot/dts/mpc8377_rdb.dts
 Reynes> @@ -109,6 +109,24 @@
 Reynes>  			reg = <0x200 0x100>;
 Reynes>  		};
 
 Reynes> +		gpio1: gpio-controller@c00 {
 Reynes> +			#gpio-cells = <2>;
 Reynes> +			compatible = "fsl,mpc8377-gpio",
 Reynes> "fsl,mpc8349-gpio";

Still word wrapped. Please try sending the patch to yourself first and
check if you can apply it before sending it to the list.

-- 
Bye, Peter Korsgaard
