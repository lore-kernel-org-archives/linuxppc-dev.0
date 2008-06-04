Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB514DDF18
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 23:41:04 +1000 (EST)
Message-Id: <B72B508B-D725-47DF-82AF-C7405EB61BBF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
In-Reply-To: <20080604150520.21b74355@i1501.lan.towertech.it>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] rtc-ds1374: Rename device to just "ds1374"
Date: Wed, 4 Jun 2008 08:40:46 -0500
References: <20080604150520.21b74355@i1501.lan.towertech.it>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 4, 2008, at 8:05 AM, Alessandro Zummo wrote:

> From: Jean Delvare <khali@linux-fr.org>
>
>
> Change the name of the device from "rtc-ds1374" to just "ds1374", to
> match what all other RTC drivers do. I seem to remember that this name
> was chosen to avoid possible confusion with an older ds1374 driver,
> but that driver was removed 3 months ago.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

Is this for 2.6.26?  also which tree is this going via?

- k
