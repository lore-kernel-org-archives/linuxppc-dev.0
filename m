Return-Path: <adaplas@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 8BC35DDEE8
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 May 2007 06:19:30 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id p76so835612pyb
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 04 May 2007 13:19:29 -0700 (PDT)
Subject: Re: [PATCH] Xilinx framebuffer device driver - 4th version
From: "Antonino A. Daplas" <adaplas@gmail.com>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
In-Reply-To: <463B504C.5050500@ru.mvista.com>
References: <463B504C.5050500@ru.mvista.com>
Content-Type: text/plain
Date: Sat, 05 May 2007 04:19:21 +0800
Message-Id: <1178309961.4729.7.camel@daplas>
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

On Fri, 2007-05-04 at 19:25 +0400, Andrei Konovalov wrote:
> Add support for the video controller IP block included into Xilinx ML300
> and ML403 reference designs.
> 

My tree does not have arch/ppc/syslib/virtex_devices.h. Either I wait
for that to be merged to the -mm or mainline tree, or you can submit
this driver yourself with the platform-specific changes. Either way:


> Signed-off-by: Andrei Konovalov <akonovalov@ru.mvista.com>
Acked-by: Antonino Daplas <adaplas@gmail.com>

Tony
