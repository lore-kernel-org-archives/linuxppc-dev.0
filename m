Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F7BFDDDEA
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Oct 2008 13:52:35 +1100 (EST)
Date: Sat, 18 Oct 2008 19:52:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] Add new framebuffer driver for Fujitsu MB862xx GDCs
Message-Id: <20081018195205.6b746f7d.akpm@linux-foundation.org>
In-Reply-To: <1223997906-19900-1-git-send-email-agust@denx.de>
References: <1223997906-19900-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 14 Oct 2008 17:25:06 +0200 Anatolij Gustschin <agust@denx.de> wrote:

> This patch adds framebuffer driver for Fujitsu
> Carmine/Coral-P(A)/Lime graphics controllers.
> Lime GDC support is known to work on PPC440EPx
> based lwmon5 and MPC8544E based socrates embedded
> boards, both equipped with Lime GDC. Carmine/Coral-P
> PCI GDC support is known to work on PPC440EPx based
> Sequoia board and also on x86 platform.

i386 allmodconfig:

drivers/video/mb862xx/mb862xxfb.h:65:2: error: #error "Select Lime GDC or CoralP/Carmine support, but not both together"
drivers/video/mb862xx/mb862xxfb.c:549: warning: 'struct of_device' declared inside parameter list
drivers/video/mb862xx/mb862xxfb.c:549: warning: its scope is only this definition or declaration, which is probably not what you want
drivers/video/mb862xx/mb862xxfb.c: In function 'of_platform_mb862xx_probe':
drivers/video/mb862xx/mb862xxfb.c:551: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c:552: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c:559: error: implicit declaration of function 'of_address_to_resource'
drivers/video/mb862xx/mb862xxfb.c:574: error: implicit declaration of function 'irq_of_parse_and_map'
drivers/video/mb862xx/mb862xxfb.c:575: error: 'NO_IRQ' undeclared (first use in this function)
drivers/video/mb862xx/mb862xxfb.c:575: error: (Each undeclared identifier is reported only once
drivers/video/mb862xx/mb862xxfb.c:575: error: for each function it appears in.)
drivers/video/mb862xx/mb862xxfb.c:664: error: implicit declaration of function 'irq_dispose_mapping'
drivers/video/mb862xx/mb862xxfb.c: At top level:
drivers/video/mb862xx/mb862xxfb.c:671: warning: 'struct of_device' declared inside parameter list
drivers/video/mb862xx/mb862xxfb.c: In function 'of_platform_mb862xx_remove':
drivers/video/mb862xx/mb862xxfb.c:673: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c:691: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c:699: error: dereferencing pointer to incomplete type
drivers/video/mb862xx/mb862xxfb.c: At top level:
drivers/video/mb862xx/mb862xxfb.c:719: error: variable 'of_platform_mb862xxfb_driver' has initializer but incomplete type
drivers/video/mb862xx/mb862xxfb.c:720: error: unknown field 'owner' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:720: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:720: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c:721: error: unknown field 'name' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:721: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:721: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c:722: error: unknown field 'match_table' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:722: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:722: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c:723: error: unknown field 'probe' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:723: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:723: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c:724: error: unknown field 'remove' specified in initializer
drivers/video/mb862xx/mb862xxfb.c:724: warning: excess elements in struct initializer
drivers/video/mb862xx/mb862xxfb.c:724: warning: (near initialization for 'of_platform_mb862xxfb_driver')
drivers/video/mb862xx/mb862xxfb.c: In function 'mb862xxfb_init':
drivers/video/mb862xx/mb862xxfb.c:1038: error: implicit declaration of function 'of_register_platform_driver'
drivers/video/mb862xx/mb862xxfb.c: In function 'mb862xxfb_exit':
drivers/video/mb862xx/mb862xxfb.c:1049: error: implicit declaration of function 'of_unregister_platform_driver'
