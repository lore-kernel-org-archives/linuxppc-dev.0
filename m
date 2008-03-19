Return-Path: <jay_chen@alphanetworks.com>
Received: from Sweeper2.alphanetworks.com (sweeper2.alphanetworks.com
	[210.202.42.140]) by ozlabs.org (Postfix) with ESMTP id 71522DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 00:00:07 +1100 (EST)
From: "jay_chen" <jay_chen@alphanetworks.com>
To: "'Nicholas Mc Guire'" <hofrat@hofr.at>
References: <017e01c887fe$41395b20$016ffea9@alphajay>
	<018401c887ff$087fc2a0$016ffea9@alphajay>
	<Pine.LNX.4.58.0803180908270.1963@vlab.hofr.at>
Subject: RE: Kernel stack overflow in process xxxx
Date: Wed, 19 Mar 2008 20:59:49 +0800
Message-ID: <038001c889c1$205d7bb0$016ffea9@alphajay>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0803180908270.1963@vlab.hofr.at>
Content-Type: text/plain;
	charset="us-ascii"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, 

My kernel version is 2.6.14.5
I don't see these options.

            Jay...
 

-----Original Message-----
From: Nicholas Mc Guire [mailto:hofrat@hofr.at] 
Sent: Wednesday, March 19, 2008 2:13 AM
To: jay_chen
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Kernel stack overflow in process xxxx


> By the way, is there any skill/tool to avoid/detect/check this kind of 
> problem?
>
did you try:

Kernel hacking  --->
  ...
  [*] Kernel debugging
  ...
  [*] Check for stack overflows
  [*] Stack utilization instrumentation

the last one depends on SysRq though.

In any case it would be interesting to know if these tools can help find
problems of this kind - so if it does not help - pleas let me/us know.

hofrat
