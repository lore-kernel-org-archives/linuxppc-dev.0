Return-Path: <ndroogh@rogers.com>
Received: from smtp107.rog.mail.re2.yahoo.com (smtp107.rog.mail.re2.yahoo.com
	[68.142.225.205]) by ozlabs.org (Postfix) with SMTP id F04DDDDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 04:43:46 +1100 (EST)
Message-ID: <47B1D943.6020708@rogers.com>
Date: Tue, 12 Feb 2008 12:37:07 -0500
From: Nick <ndroogh@rogers.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: DTS question - MPC5200b
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I need some help.  I am trying to access timer 7 on the MPC5200B 
processor.  I have the DTS file setup like this

        gpt@670 {    // General Purpose Timer
          device_type = "gpt";
            compatible = "fsl,mpc5200b-gpt","fsl,mpc5200-gpt";
            cell-index = <7>;
            reg = <670 10>;
            interrupts = <1 10 0>;
            interrupt-parent = <&mpc5200_pic>;
        };

I have timers 0 to 6 defined the same way except the cell-index reflects 
the timer number.

In my platform file where I am doing my board setup, I tried the  following.

timer7 = mpc52xx_find_and_map ("mpc5200b-gpt");

How do I specify the timer based on the cell-index?

Thanks

Nick
