Return-Path: <liyaoshi@21cn.com>
Received: from 21cn.com (unknown [202.105.45.52])
	by ozlabs.org (Postfix) with SMTP id 2765667B61
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 18:54:38 +1000 (EST)
Received: from HuangXiongWei (unknown [202.105.45.9])
	by 21cn.com (HERMES) with ESMTP for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 Aug 2006 16:47:44 +0800 (HKT)
Date: Tue, 1 Aug 2006 16:47:26 +0800
From: "liyaoshi" <liyaoshi@21cn.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: 8247 usb host driver of  kernel 2.6.12 with cpm2usb patched
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-ID: <yA939198834879.07252@send6.inner-21cn.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello guys
		I have a board of 8247 ,I have get it run with kernel patched with cpm2usb 
		It seems the irq of usb in 8247 dont work
		the proc looks like the follow 

			bash-3.00# cat /proc/interrupts 
			           CPU0       
			 11:          0   CPM2 SIU  Level     m82xxhci
			 32:          0   CPM2 SIU  Level     fenet
			 33:      72876   CPM2 SIU  Level     fenet
			 40:        389   CPM2 SIU  Level     cpm_uart
			BAD:       5611                                               

		And I have seen the same question in the mail list , somebody just say set the correct USBCLK,
		i modify the board_configure and setup_usb_clock function   , and i make sure the usbclock is correct set

        The chipset looks like of Version A.0 

			bash-3.00# cat /proc/cpuinfo 
			processor       : 0
			cpu             : G2_LE
			revision        : 1.4 (pvr 8082 2014)
			bogomips        : 177.15 

		Any other Thing should I modify to generate the usb interrupt ? 
