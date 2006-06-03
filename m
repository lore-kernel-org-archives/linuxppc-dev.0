Return-Path: <shantanu.nalage@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 21B17679FF
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Jun 2006 21:45:03 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so746577ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 03 Jun 2006 04:44:58 -0700 (PDT)
Message-ID: <c91756f0606030438y62772d89ib43f613cd5373739@mail.gmail.com>
Date: Sat, 3 Jun 2006 17:08:21 +0530
From: "Shantanu Nalage" <shantanu.nalage@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Making Two ethernet interfaces up in Linux
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
         We are trying to port Linux on Xilinx Board XUPV2Pro which is
similar in most aspects to the Xilinx ML300 board. Linux is up and
running for the original board i.e. having only one ethrnet interface.
Now since we wanted to have the board working as router, we designed a
daughter board with two ethernet phy interfaces. The MACs required for
that are instantiated in Xilinx and corresponding Board support
Packages are also created in Xilinx.
        What all changes are required to make both the interfaces
visible in Linux?

Thank you in anticipation.

With regards,

Shantanu.
