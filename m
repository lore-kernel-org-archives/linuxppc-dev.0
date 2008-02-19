Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by ozlabs.org (Postfix) with ESMTP id 753C6DE03F
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 02:24:17 +1100 (EST)
Date: Tue, 19 Feb 2008 16:24:15 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] Convert pfc8563 i2c driver from old style to new style
Message-ID: <20080219162415.601c7efe@hyperion.delvare>
In-Reply-To: <9e4733910802190717g3a4b6ddejbd180a32d7dfae47@mail.gmail.com>
References: <20080121200901.15517.30253.stgit@terra.home>
	<20080219161020.61f7ec10@hyperion.delvare>
	<9e4733910802190717g3a4b6ddejbd180a32d7dfae47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Alessandro Zummo <alessandro.zummo@towertech.it>,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 19 Feb 2008 10:17:43 -0500, Jon Smirl wrote:
> On 2/19/08, Jean Delvare <khali@linux-fr.org> wrote:
> > Hi Jon,
> >
> > On Mon, 21 Jan 2008 15:09:01 -0500, Jon Smirl wrote:
> > > Convert pfc8563 i2c driver from old style to new style.
> 
> Let's just forget about this patch until the dynamic module loading
> support goes into the base.

Why? I don't see the rationale. New-style drivers are good even without
dynamic module loading.

> The Phytec PCM030 mpc5200 board uses this chip. They are staying out
> of tree because they've integrated real-time support which is not in
> mainline yet.


-- 
Jean Delvare
