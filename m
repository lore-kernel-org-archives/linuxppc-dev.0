Return-Path: <timur.tabi@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 73DB1DDF93
	for <linuxppc-dev@ozlabs.org>; Sat,  9 May 2009 03:23:20 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so847081ywt.39
	for <linuxppc-dev@ozlabs.org>; Fri, 08 May 2009 10:23:18 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <4A0457BC.3040408@dlasys.net>
References: <4A0457BC.3040408@dlasys.net>
Date: Fri, 8 May 2009 12:15:12 -0500
Message-ID: <ed82fe3e0905081015n41e1edd1l3908f68e0c8a7aa5@mail.gmail.com>
Subject: Re: device trees.
From: Timur Tabi <timur@freescale.com>
To: dhlii@dlasys.net
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 8, 2009 at 11:03 AM, David H. Lynch Jr. <dhlii@dlasys.net> wrot=
e:
> =A0 =A0Is there an example somewhere that shows building a device tree on
> the fly ?

A whole device tree?  I don't think so.  U-Boot does manipulate quite
a few properties, but it assume that the DTS lists all the devices.

Remember, one of the primary purposes of the DTS is to list devices
that cannot be probed.

--=20
Timur Tabi
Linux kernel developer at Freescale
