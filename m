Return-Path: <egoforth@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 2BB5067A2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Mar 2005 03:42:38 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 71so2773128wra
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 14 Mar 2005 08:42:36 -0800 (PST)
Message-ID: <4235BD6A.5000004@gmail.com>
Date: Mon, 14 Mar 2005 11:35:54 -0500
From: Ed Goforth <egoforth@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: I2C RTC recommendations?
Reply-To: egoforth@gmail.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm looking to add a RTC to a custom 440gx-based board.  The board
developer has indicated that they would prefer use an I2C device (vs.
eg. something like the DS1743 that's on the reference board).

Does anyone have any recommendations or comments?  The primary
consideration is that it be easily supported with a 2.4.x kernel.  The
only important function is the timekeeper function (though a WD
capability might be useful in the future).

Thanks in advance,
Ed
