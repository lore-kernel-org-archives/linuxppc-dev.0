Return-Path: <j.lu@tiesse.com>
Received: from tiesse.com (studiogesan.it [193.76.202.5])
	by ozlabs.org (Postfix) with ESMTP id A27BB67B1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Jun 2005 00:44:58 +1000 (EST)
Date: Tue, 21 Jun 2005 16:48:13 +0200
Message-Id: <200506211648.AA102695630@tiesse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Jianliang Lu" <j.lu@tiesse.com>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: isp1362 usb driver
Reply-To: j.lu@tiesse.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Wolfhang,
sorry for my persistence, now I try to go to more detail:
I've downloaded the driver from denx, that is part of kernel-
2.4.25, files isp1362-ctl.c, isp1362-ep1.c isp1362-ep2.c, isp1362-
ctl.h, hcd-1161.c and hcd-1161.h. But after it was installed we 
have had problems on bulk/control during the initializing. 

Following are logs:
---
Jan  1 01:01:29 IMOLA kernel: isp1362-HC Initialization Successful
Jan  1 01:01:29 IMOLA kernel: hub.c: port 1, portstatus 100, 
change 0, 12 Mb/s
Jan  1 01:01:29 IMOLA kernel: hub.c: port 2, portstatus 101, 
change 1, 12 Mb/s
Jan  1 01:01:29 IMOLA kernel: hub.c: port 2 connection change
Jan  1 01:01:29 IMOLA kernel: hub.c: port 2, portstatus 101, 
change 1, 12 Mb/s
Jan  1 01:01:29 IMOLA kernel: hub.c: port 2, portstatus 101, 
change 0, 12 Mb/s
Jan  1 01:01:30 IMOLA last message repeated 3 times
Jan  1 01:01:30 IMOLA kernel: hub.c: port 2, portstatus 103, 
change 10, 12 Mb/s
Jan  1 01:01:30 IMOLA kernel: hub.c: USB new device connect on 
bus2/2, assigned device number 2
Jan  1 01:01:33 IMOLA kernel: usb_control/bulk_msg: timeout
Jan  1 01:01:45 IMOLA last message repeated 4 times
Jan  1 01:01:45 IMOLA kernel: usb.c: couldn't get all of config 
descriptors
Jan  1 01:01:45 IMOLA kernel: usb.c: unable to get device 2 
configuration (error=-110)
Jan  1 01:01:45 IMOLA kernel: hub.c: port 2, portstatus 103, 
change 10, 12 Mb/s
Jan  1 01:01:45 IMOLA kernel: hub.c: USB new device connect on 
bus2/2, assigned device number 3
Jan  1 01:01:48 IMOLA kernel: usb_control/bulk_msg: timeout
Jan  1 01:02:00 IMOLA last message repeated 4 times
Jan  1 01:02:00 IMOLA kernel: usb.c: couldn't get all of config 
descriptors
Jan  1 01:02:00 IMOLA kernel: usb.c: unable to get device 3 
configuration (error=-110)
Jan  1 01:02:00 IMOLA kernel: hub.c: port 1, portstatus 100, 
change 0, 12 Mb/s
Jan  1 01:02:00 IMOLA kernel: hub.c: port 2, portstatus 101, 
change 0, 12 Mb/s
---

Best regards,
Jianliang Lu
                   
