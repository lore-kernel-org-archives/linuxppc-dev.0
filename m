Return-Path: <adaplas@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id BA728DDED3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 May 2007 20:44:41 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id p76so931547pyb
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 05 May 2007 03:44:39 -0700 (PDT)
Subject: Re: [PATCH] Xilinx framebuffer device driver - 4th version
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
In-Reply-To: <1178309961.4729.7.camel@daplas>
References: <463B504C.5050500@ru.mvista.com> <1178309961.4729.7.camel@daplas>
Content-Type: text/plain
Date: Sat, 05 May 2007 18:44:29 +0800
Message-Id: <1178361869.4706.0.camel@daplas>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 2007-05-05 at 04:19 +0800, Antonino A. Daplas wrote:
> On Fri, 2007-05-04 at 19:25 +0400, Andrei Konovalov wrote:
> > Add support for the video controller IP block included into Xilinx ML300
> > and ML403 reference designs.
> > 
> 
> My tree does not have arch/ppc/syslib/virtex_devices.h. Either I wait
> for that to be merged to the -mm or mainline tree, or you can submit
> this driver yourself with the platform-specific changes. Either way:

Okay, the platform-specific parts are in 2.6.21-mm1 already. I'll push
this patch upstairs.

Tony
