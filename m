Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id AC090DDF67
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 02:17:46 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so3437385wag.13
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 07:17:45 -0800 (PST)
Message-ID: <9e4733910802190717g3a4b6ddejbd180a32d7dfae47@mail.gmail.com>
Date: Tue, 19 Feb 2008 10:17:43 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [PATCH] Convert pfc8563 i2c driver from old style to new style
In-Reply-To: <20080219161020.61f7ec10@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121200901.15517.30253.stgit@terra.home>
	<20080219161020.61f7ec10@hyperion.delvare>
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

On 2/19/08, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Jon,
>
> On Mon, 21 Jan 2008 15:09:01 -0500, Jon Smirl wrote:
> > Convert pfc8563 i2c driver from old style to new style.

Let's just forget about this patch until the dynamic module loading
support goes into the base.

The Phytec PCM030 mpc5200 board uses this chip. They are staying out
of tree because they've integrated real-time support which is not in
mainline yet.

-- 
Jon Smirl
jonsmirl@gmail.com
