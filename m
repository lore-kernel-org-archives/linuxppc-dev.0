Return-Path: <jacmet@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.27])
	by ozlabs.org (Postfix) with ESMTP id 07BCEDDF21
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 06:17:39 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 9so19013eyd.15
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 11:17:35 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: "Reynes Philippe" <philippe.reynes@isismpp.fr>
Subject: Re: [PATCH] add gpio to mpc837X rdb
References: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Thu, 29 Jan 2009 20:17:33 +0100
In-Reply-To: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
	(Reynes Philippe's message of "Thu\,
	29 Jan 2009 18\:37\:15 +0100")
Message-ID: <87y6wtq5v6.fsf@macbook.be.48ers.dk>
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

Hi,

 Reynes> Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
 
 Reynes> +		gpio1: gpio-controller@c00 {
 Reynes> +			#gpio-cells = <2>;
 Reynes> +			compatible = "fsl,mpc8347-gpio",
 Reynes> "fsl,mpc8349-gpio";

The patch is wordwrapped, and you should use fsl,mpc8377-gpio, not
mpc8347 (E.G. <actual platform>, mpc8349)

-- 
Bye, Peter Korsgaard
