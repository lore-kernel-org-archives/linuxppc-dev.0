Return-Path: <jonsmirl@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by ozlabs.org (Postfix) with ESMTP id 2EE4DDDEDE
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 06:49:59 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so1064768nzh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jan 2008 11:49:58 -0800 (PST)
Message-ID: <9e4733910801021149h15abab7cr9d4f4d931b838114@mail.gmail.com>
Date: Wed, 2 Jan 2008 14:49:57 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jochen Friedrich" <jochen@scram.de>
Subject: Re: [PATCH 4/5] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
In-Reply-To: <477BE8F8.9030804@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071220044136.20091.70984.stgit@terra.home>
	<20071220044144.20091.35917.stgit@terra.home>
	<477BE8F8.9030804@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/2/08, Jochen Friedrich <jochen@scram.de> wrote:
>
> Should this go into some central file? Else we would have to copy it in any i2c bus driver that supports powerpc.
> This would at least be i2c-cpm and i2c-gpio.

I can change that in the next rev. I'm waiting to see if there are any
more changes.

> IMHO, there should be a node attribute to override i2c_adapter.class. Legacy i2c drivers (in particular v4l and dvb drivers) use this class to decide which adapter to bind to. dbox2 needs I2C_CLASS_TV_DIGITAL (4).

I hadn't paid any attention to i2c_adapter.class. Now that you mention
it I wonder why i2c has it.  It appears to be a holdover from the
older mechanism of searching for devices and it is used as a filter to
reduce the number of device being searched. I would think a new style
driver could just ignore it.

It is probably best to fix it in a successive patch.


-- 
Jon Smirl
jonsmirl@gmail.com
