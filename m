Return-Path: <robertlazarski@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.234])
	by ozlabs.org (Postfix) with ESMTP id 203C2DDE2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Nov 2007 00:25:33 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so435583nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 09 Nov 2007 05:25:31 -0800 (PST)
Message-ID: <f87675ee0711090525n5687201fs102054f761cec20b@mail.gmail.com>
Date: Fri, 9 Nov 2007 08:25:31 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: auto soft reset after kernel crash?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm trying to read the __log_buf after a kernel crash on a custom
board via a software reset. While I'm waiting for the hardware guys to
give me a sw reset button, I've noticed that the particular 2.6.22
kernel I'm using software resets itself around 7 minutes after a
crash. I tried a 2.6.23 kernel to see if my problem was related to
kernel version and it doesn't reset itself. Is this reset indeed a
kernel feature? How do I enable / disable it and set the amount of
time it waits before it resets? I went thru the menuconfig features
and couldn't enable a sw reset. Any ideas?

Thanks,
Robert
