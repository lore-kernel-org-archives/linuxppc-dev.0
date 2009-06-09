Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6A5E3B70C7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 13:19:38 +1000 (EST)
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id C0300DDD01
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 13:19:36 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1758771ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 08 Jun 2009 20:19:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090609.102054.125129248.saito@densan.co.jp>
References: <20090609.102054.125129248.saito@densan.co.jp>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 8 Jun 2009 21:19:14 -0600
Message-ID: <fa686aa40906082019s311cdf8bg8ee9e33b7a1884cd@mail.gmail.com>
Subject: Re: sensors can't be detected on i2c-mpc
To: Hide Saito <hsaito.ppc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, saito@densan.co.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 8, 2009 at 7:20 PM, Hide Saito<hsaito.ppc@gmail.com> wrote:
> sensors can't be detected on i2c-mpc
>
> Hi all,
>
> The sensors can't be detected on the built-in I2C interface on the Freescale's MPC processors on linux-2.6.29.
> If it is not yet fixed, I think that it is forgotten to set the following values in the class.
>
> Signed-off-by: Hideo Saito <hsaito.ppc@gmail.com>

Since i2c probing is hit and miss at best; Most MPCxxxx SPI busses get
the i2c bus topology out of the device tree file
(arch/powerpc/boot/dts/<board-name>.dts) and do not support probing.
If the i2c device you need is missing, then add a node to the .dts
file for the missing device (there are lots of examples of this in the
dts directory).

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
