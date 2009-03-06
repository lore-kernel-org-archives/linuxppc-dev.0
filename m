Return-Path: <alohanono@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.26])
	by ozlabs.org (Postfix) with ESMTP id 8605BDDF05
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 02:58:11 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 9so42907eyd.15
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 07:58:09 -0800 (PST)
Message-ID: <49B1469B.9030609@gmail.com>
Date: Fri, 06 Mar 2009 16:51:55 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: USB Host in 2.6.24-r3 Arch=PPC
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

 just a little question. I am using 2.6.24-rc3 (secretlab) and I would
like to use c67x00 driver from Peter Kosgaard for USB-Host in my Xilinx
ML403 board. Is there support to use USB Host in Arch=ppc  Apparently I
cannot select  CONFIG_USB_ARCH_HAS_HCD=y option. What should I do to get
the USB working? Is there any backport for hcd support in arch=ppc?
Should I upgrade to powerpc (  painful ) ?

Thx,

/Albert
