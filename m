Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 7839ADDE1A
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 07:24:57 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3072305wag
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Dec 2007 12:24:55 -0800 (PST)
Message-ID: <9e4733910712091224mcb43f0ci69f578d221505ba7@mail.gmail.com>
Date: Sun, 9 Dec 2007 15:24:55 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: i2c@lm-sensors.org, linuxppc-dev@ozlabs.org,
	"Jean Delvare" <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH 0/4] Series to add device tree naming to i2c
In-Reply-To: <20071203212032.23543.3453.stgit@terra.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071203212032.23543.3453.stgit@terra.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What is the status of this series, is there anything I can do to help
get this into the i2c subsystem?

On 12/3/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> The following series implements standard linux module aliasing for i2c modules
> It then converts the mpc i2c driver from being a platform driver to an open
> firmware one. I2C device names are picked up from the device tree. Module
> aliasing is used to translate from device tree names into to linux kernel
> names. Several i2c drivers are updated to use the new aliasing.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>
> _______________________________________________
> i2c mailing list
> i2c@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/i2c
>


-- 
Jon Smirl
jonsmirl@gmail.com
