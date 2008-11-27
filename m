Return-Path: <timur.tabi@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 5656EDDDD8
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 02:25:01 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so428120ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 07:24:59 -0800 (PST)
Message-ID: <ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
Date: Thu, 27 Nov 2008 09:24:59 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Andre Schwarz" <andre.schwarz@matrix-vision.de>
Subject: Re: i2c-mpc clocking scheme
In-Reply-To: <492EB606.9020703@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <492EB606.9020703@matrix-vision.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2008 at 9:00 AM, Andre Schwarz
<andre.schwarz@matrix-vision.de> wrote:
> All,
>
> is anybody working on some improvements regarding configurable I2C
> frequency inside the i2c-mpc driver ?
>
> If not - would anybody be intersted in getting this done, i.e.
> configurable via device tree ?

Maybe I'm missing something, but U-Boot configures the I2C bus speed.
It does this because the algorithm is specific to the SOC itself.  For
example, the 8544 is different from the 8548.  It would be a mess to
duplicate this code in the kernel.

-- 
Timur Tabi
Linux kernel developer at Freescale
