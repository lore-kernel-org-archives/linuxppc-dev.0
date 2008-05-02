Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C721DDF07
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 06:27:29 +1000 (EST)
Date: Fri, 2 May 2008 22:27:17 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] mpc i2c driver, compare to NO_IRQ instead of zero
Message-ID: <20080502222717.519b68e8@hyperion.delvare>
In-Reply-To: <9e4733910805021019t6fb94ed0m63a82ba7103c0202@mail.gmail.com>
References: <20080121200740.13800.20524.stgit@terra.home>
	<20080219174221.5b18cba8@hyperion.delvare>
	<9e4733910805020723p7900c132j872893113f9d739e@mail.gmail.com>
	<20080502164610.277ec04b@hyperion.delvare>
	<9e4733910805020902ga4f05b3nfd2221511ec2ebba@mail.gmail.com>
	<20080502182917.41dc560e@hyperion.delvare>
	<9e4733910805021019t6fb94ed0m63a82ba7103c0202@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2 May 2008 13:19:44 -0400, Jon Smirl wrote:
> I attached the diff file. I had forgot that I renamed the file so it
> wasn't getting compiled. I compiled it this time. I've made too many
> other changes to it to test this version on my current hardware.

Applied, thanks.

-- 
Jean Delvare
