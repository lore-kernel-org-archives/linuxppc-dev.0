Return-Path: <jay_chen@alphanetworks.com>
Received: from Sweeper2.alphanetworks.com (sweeper2.alphanetworks.com
	[210.202.42.140]) by ozlabs.org (Postfix) with ESMTP id A1385DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Mar 2008 18:08:44 +1100 (EST)
From: "jay_chen" <jay_chen@alphanetworks.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Kernel stack overflow in process xxxx
Date: Mon, 17 Mar 2008 15:12:22 +0800
Message-ID: <017e01c887fe$41395b20$016ffea9@alphajay>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello all:

I am using mpc8548 and, kernel 2.6.14.5.
Recently, my system encounter "Kernel stack overflow in process xxxx"
problem.
How to increase the kernel stack size?
I try to modify THREAD_SIZE in thread_info.h, but my system seems couldn't
boot up anymore!

//#define THREAD_SIZE		8192	/* 2 pages */
#define THREAD_SIZE		  16384	/* 4 pages */

Thanks in advance for any kind of advice.

          Jay Chen...
