Return-Path: <frannk_m1@yahoo.com>
Received: from web13807.mail.yahoo.com (web13807.mail.yahoo.com
	[216.136.175.17]) by ozlabs.org (Postfix) with SMTP id 332E62BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Nov 2004 04:57:26 +1100 (EST)
Message-ID: <20041129175045.9279.qmail@web13807.mail.yahoo.com>
Date: Mon, 29 Nov 2004 09:50:45 -0800 (PST)
From: Frank <frannk_m1@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: fbmem.c compile problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to get framebuffer support compiled into the kernel
(2.4.28) before I compile and install directfb, but I am having
a problem I can't seem to solve. I am getting the following
error when I try to compile fb support into the kernel:
/drivers/char/mem.c:747: undefined reference to `fbmem_init'

I have what I think i need enabled in my .config file:

# 
# Console drivers
#
CONFIG_VGA_CONSOLE=y
#
# Frame-buffer support
#
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
# CONFIG_FB_VOYAGER is not set
# CONFIG_FB_MB86290 is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_CLGEN is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_CT65550 is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_S3TRIO is not set
CONFIG_FB_VESA=y
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_LYNX is not set
# CONFIG_FB_SM712 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_ATY is not set
CONFIG_FB_RADEON=y
# CONFIG_FB_ATY128 is not set

Can someone shed some light on why, although I have CONFIG_FB
set
to 'y' the makefile won't compile drivers/video/fbmem.c

I am on a very tight schedule and any help would be greatly 
appreciated....


	
		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - You care about security. So do we. 
http://promotions.yahoo.com/new_mail
