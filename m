Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-102-tuesday.noc.nerim.net
	[62.4.17.102]) by ozlabs.org (Postfix) with ESMTP id 975F1DDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 00:59:59 +1100 (EST)
Date: Tue, 19 Feb 2008 14:58:23 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] Convert pfc8563 i2c driver from old style to new
	style
Message-ID: <20080219145823.0d716665@hyperion.delvare>
In-Reply-To: <9e4733910801250916o15e9a64an754997dd79ebcff5@mail.gmail.com>
References: <20080121200901.15517.30253.stgit@terra.home>
	<9e4733910801250916o15e9a64an754997dd79ebcff5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

On Fri, 25 Jan 2008 12:16:46 -0500, Jon Smirl wrote:
> Any final objections to this patch? Jean can you pick it up?

Sorry for the delay, I'll review your patch right now. Note that the
driver is really named pcf8563 not pfc8563.

-- 
Jean Delvare
