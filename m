Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by ozlabs.org (Postfix) with ESMTP id 2613DDDE2C
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jan 2008 02:14:18 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1521306rvf.9
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jan 2008 07:14:14 -0800 (PST)
Message-ID: <9e4733910801130714m1be16826jf240171972324d16@mail.gmail.com>
Date: Sun, 13 Jan 2008 10:14:14 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [i2c] [PATCH] update module-init-tools to support the i2c
	subsystem
In-Reply-To: <20080113152735.5dca46a1@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910712171839h214e0bc3q179266c86e5987b1@mail.gmail.com>
	<20080113152735.5dca46a1@hyperion.delvare>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/13/08, Jean Delvare <khali@linux-fr.org> wrote:
> On Mon, 17 Dec 2007 21:39:37 -0500, Jon Smirl wrote:
> > Follow on to: "Series to add device tree naming to i2c"
> > Teach module-init-tools about the i2c subsystem.
>
> Can you please explain what this patch does and why it is needed?

It generates the entries needed for the user space module tools to
work with the aliases. For example modprobe/depmod. It is a standard
part of the kernel module system.

-- 
Jon Smirl
jonsmirl@gmail.com
