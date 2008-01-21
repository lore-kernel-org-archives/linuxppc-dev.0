Return-Path: <jonsmirl@gmail.com>
Received: from hs-out-2122.google.com (hs-out-0708.google.com [64.233.178.248])
	by ozlabs.org (Postfix) with ESMTP id EC63DDDE06
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 03:57:28 +1100 (EST)
Received: by hs-out-2122.google.com with SMTP id x43so2242755hsb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 08:57:23 -0800 (PST)
Message-ID: <9e4733910801210850j39b9d51fy706b58ca15805f35@mail.gmail.com>
Date: Mon, 21 Jan 2008 11:50:13 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH 2/3] i2c: Convert all new-style drivers to use module
	aliasing
In-Reply-To: <20080121114139.3aaa111a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121112517.6fe35a89@hyperion.delvare>
	<20080121114139.3aaa111a@hyperion.delvare>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In my version of these patches new style drivers could be loaded with
both the driver_name/name scheme and the modalias. In these patches
new style drivers can only be loaded via modalias. Is that what you
intended? I'm all for making new style driver only use the modalias
scheme.

-- 
Jon Smirl
jonsmirl@gmail.com
