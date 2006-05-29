Return-Path: <lagrange@fr.oleane.com>
Received: from relay04s.clb.oleane.net (relay04s.clb.oleane.net
	[213.56.31.142]) by ozlabs.org (Postfix) with ESMTP id BF46367A41
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 01:57:04 +1000 (EST)
Received: from smtp3.clb.oleane.net (smtp3.clb.oleane.net [213.56.31.19])
	by relay04s.clb.oleane.net with ESMTP id k4TFrftY020207
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 May 2006 17:57:02 +0200
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp3.clb.oleane.net with ESMTP id k4TFYbvN001620
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 May 2006 17:34:40 +0200
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linux kernel thread with Linux 2.6.x
Date: Mon, 29 May 2006 17:35:13 +0200
Message-ID: <000201c68335$7c594b90$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <000001c65d85$5e699890$5201a8c0@GEG2400>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello everybody,

I'm writing a custom network driver based on a MPC8260 FCC device for a
2.6.9 linux kernel.
In this driver, I need to use specific buffer allocation functions which use
down and up semaphore functions.

As the interrupt handler can't be scheduled, I have made a kernel thread
which waits forever on a semaphore.
This semaphore is set when a received packet interrupt occured. All that
mechanism works but the performances
are very poor.

Is there any solution to increase the kthread priority in the scheduler ?
Is there another solution than the semaphore to quickly wake up a kthread ?

Thanks a lot for your help.
Laurent
