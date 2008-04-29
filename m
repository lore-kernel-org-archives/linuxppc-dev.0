Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 87D0FDDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 22:16:15 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so8043220wag.13
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 05:16:13 -0700 (PDT)
Message-ID: <9e4733910804290516g1fd0b653jae63e811409e00f9@mail.gmail.com>
Date: Tue, 29 Apr 2008 08:16:13 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH 1/2 v2] i2c: Add support for device alias names
In-Reply-To: <20080429124621.07e6efd6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080429124241.08e18ae3@hyperion.delvare>
	<20080429124621.07e6efd6@hyperion.delvare>
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mundt <lethal@linux-sh.org>, Linux I2C <i2c@lm-sensors.org>,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 4/29/08, Jean Delvare <khali@linux-fr.org> wrote:
> Based on earlier work by Jon Smirl and Jochen Friedrich.
>  +/* Looks like: i2c:S */
>  +static int do_i2c_entry(const char *filename, struct i2c_device_id *id,
>  +                       char *alias)
>  +{
>  +       sprintf(alias, I2C_MODULE_PREFIX "%s", id->name);

Do you want to add the colon?

>  +
>  +       return 1;
>  +}

-- 
Jon Smirl
jonsmirl@gmail.com
