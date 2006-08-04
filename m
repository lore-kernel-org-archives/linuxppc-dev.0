Return-Path: <paravpandit@yahoo.com>
Received: from web36613.mail.mud.yahoo.com (web36613.mail.mud.yahoo.com
	[209.191.85.30]) by ozlabs.org (Postfix) with SMTP id CFAAB67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Aug 2006 20:18:00 +1000 (EST)
Message-ID: <20060804101758.6282.qmail@web36613.mail.mud.yahoo.com>
Date: Fri, 4 Aug 2006 03:17:58 -0700 (PDT)
From: Parav Pandit <paravpandit@yahoo.com>
Subject: ioctl() hangs in Lite5200b FEC driver?
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

1. Is drivers/net/fec.c is the correct driver for the
Lite5200B board in 2.6.x?

2. If yes, it doesn't have any implementation for
do_ioctl() call.
In my case ifconfig tries to set the IFF_RUNNING |
IFF_UP flag using SIOCGIFFLAGS ioctl cmd, but my
ifconfig utility hangs in the ioctl().
Can some one tell me why does it hang?
Can some one tell me, when do_ioctl() is not
implemented by the driver, than which default function
gets called by the system?

Regards,
Parav Pandit


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
