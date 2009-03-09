Return-Path: <vijay.t.nikam@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id E1B1CDDFF7
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 17:33:28 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so1379452rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 08 Mar 2009 23:33:26 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 9 Mar 2009 12:03:26 +0530
Message-ID: <f234e2140903082333t7e7e365g800f6f0059d0bf02@mail.gmail.com>
Subject: fasync (Async Notification)
From: Vijay Nikam <vijay.t.nikam@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All,

I have mpc8313erdb eval board and kernel 2..6.20 on it. I have written
GPIO driver and have enabled Async Notification (SIGIO)

In the driver I am generating interrupt whenever the status of GPIO
pin (GPIO 2) changes, this part is working correct (as soon as the
GPIO pin status changes the interrupt is generated).

Then I included Async Notification to notify the particluar user space
process (to the process which I want to) by using fasync method,
kill_fasync is called in Interrupt handler and also the kill_fasync
signals the particular process and the Signal handler executes and
says SIGIO is received.

But the problem is, if I change GPIO pin status twice then two
interrupts are generated but I get SIGIO Async Notification only once.
Whereras I am expecting that I should get twice SIGIO Async
Notification (Theory says the same).

Could anyone please let me what is the reason for this ? ? ?

Kindly please acknowledge ... thank you ...

Kind Regards,
Vijay Nikam
