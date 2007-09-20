Return-Path: <jonsmirl@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by ozlabs.org (Postfix) with ESMTP id 8F25ADDE06
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Sep 2007 02:21:32 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so476544nzh
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Sep 2007 09:21:31 -0700 (PDT)
Message-ID: <9e4733910709200921u3ffd6a37pe0ef268a2a171973@mail.gmail.com>
Date: Thu, 20 Sep 2007 12:21:30 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: Printing device tree on running system
In-Reply-To: <20070920160804.GA15796@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910709200855p5a1cdf18v1848a31c7935ca5e@mail.gmail.com>
	<20070920160804.GA15796@ld0162-tx32.am.freescale.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/20/07, Scott Wood <scottwood@freescale.com> wrote:
> On Thu, Sep 20, 2007 at 11:55:10AM -0400, Jon Smirl wrote:
> > Is there a command for printing the device tree on a running system? I
> > want to see what changes the various device drivers made to the DTC I
> > started with.
>
> It's exported in /proc/device-tree, if support is built into the kernel.

That worked, didn't know the option existed.

>
> It might be interesting to make dtc support turning that into a dts...

That would be useful, you could do a diff and see how the tree was altered.

The case I just looked at was old code manually building entries for
i2c devices in the tree, but with an updated dts the devices are
already in the tree which explains the error I got about conflicting
device nodes.


>
> -Scott
>


-- 
Jon Smirl
jonsmirl@gmail.com
