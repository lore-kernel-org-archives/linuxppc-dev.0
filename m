Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6E3C4DDEE3
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 10:07:53 +1100 (EST)
Date: Sat, 28 Mar 2009 10:06:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Albrecht =?utf-8?B?RHJl77+9?= <albrecht.dress@arcor.de>
Subject: Re: Q: define i2c nodes in device tree?
Message-ID: <20090327230615.GB20387@yookeroo.seuss>
References: <17008330.1238159104446.JavaMail.ngmail@webmail11.arcor-online.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <17008330.1238159104446.JavaMail.ngmail@webmail11.arcor-online.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 27, 2009 at 02:05:04PM +0100, Albrecht Dre� wrote:
> Hi Timur:
> 
> > You need to have a "gpio I2C" device driver that registers the same name as what's in the DTS, like this:
> 
> Thanks, that did the trick; a proper naming is apparently
> 
> pca8575:gpio@20 {
>         compatible = "nxp,pca8575";
>         device_type = "gpio";

There shouldn't be device_type here, though.

>         reg = <0x20 1>;
> };

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
