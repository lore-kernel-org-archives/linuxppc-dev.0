Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-102-tuesday.noc.nerim.net
	[62.4.17.102]) by ozlabs.org (Postfix) with ESMTP id 86EC2DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 21:09:55 +1100 (EST)
Date: Tue, 22 Jan 2008 11:09:51 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/3] i2c: Convert all new-style drivers to use module
	aliasing
Message-ID: <20080122110951.6d896b2b@hyperion.delvare>
In-Reply-To: <9e4733910801210850j39b9d51fy706b58ca15805f35@mail.gmail.com>
References: <20080121112517.6fe35a89@hyperion.delvare>
	<20080121114139.3aaa111a@hyperion.delvare>
	<9e4733910801210850j39b9d51fy706b58ca15805f35@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Jon,

On Mon, 21 Jan 2008 11:50:13 -0500, Jon Smirl wrote:
> In my version of these patches new style drivers could be loaded with
> both the driver_name/name scheme and the modalias. In these patches
> new style drivers can only be loaded via modalias. Is that what you
> intended? I'm all for making new style driver only use the modalias
> scheme.

Yes, this is what I intended. I see no point in having two ways to
achieve the same result, it makes things more complex, more costly and
possibly confusing.

I would reconsider if someone points out a very good reason to keep both
schemes in parallel.

-- 
Jean Delvare
