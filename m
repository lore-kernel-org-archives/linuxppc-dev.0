Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-100-sunday.nerim.net [62.4.16.100])
	by ozlabs.org (Postfix) with ESMTP id 61B89DDE0E
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 04:43:38 +1100 (EST)
Date: Sun, 13 Jan 2008 18:43:37 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [i2c] [PATCH] update module-init-tools to support the i2c
	subsystem
Message-ID: <20080113184337.5d4cd546@hyperion.delvare>
In-Reply-To: <9e4733910801130826l799e4897pe7380ccb973b5fd0@mail.gmail.com>
References: <9e4733910712171839h214e0bc3q179266c86e5987b1@mail.gmail.com>
	<20080113152735.5dca46a1@hyperion.delvare>
	<9e4733910801130714m1be16826jf240171972324d16@mail.gmail.com>
	<20080113163543.16e3d26b@hyperion.delvare>
	<9e4733910801130826l799e4897pe7380ccb973b5fd0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 13 Jan 2008 11:26:07 -0500, Jon Smirl wrote:
> On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> > On Sun, 13 Jan 2008 10:14:14 -0500, Jon Smirl wrote:
> > > On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> > > > On Mon, 17 Dec 2007 21:39:37 -0500, Jon Smirl wrote:
> > > > > Follow on to: "Series to add device tree naming to i2c"
> > > > > Teach module-init-tools about the i2c subsystem.
> > > >
> > > > Can you please explain what this patch does and why it is needed?
> > >
> > > It generates the entries needed for the user space module tools to
> > > work with the aliases. For example modprobe/depmod. It is a standard
> > > part of the kernel module system.
> >
> > What entries, where? What can you do after applying your patch that you
> > couldn't do before?
> 
> The drivers you are testing with don't depend on other drivers.

They do. I'm testing with the lm90 driver, which depends on the hwmon
driver. Both load automatically when the underlying i2c-parport driver
instantiate an "adm1032" i2c device.

-- 
Jean Delvare
