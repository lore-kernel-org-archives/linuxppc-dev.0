Return-Path: <hofrat@hofr.at>
Received: from mail.hofr.at (unknown [194.112.174.227])
	by ozlabs.org (Postfix) with ESMTP id D0058DE059
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Mar 2008 04:33:44 +1100 (EST)
Date: Tue, 18 Mar 2008 09:12:59 -0900 (AKST)
From: Nicholas Mc Guire <hofrat@hofr.at>
To: jay_chen <jay_chen@alphanetworks.com>
Subject: RE: Kernel stack overflow in process xxxx
In-Reply-To: <018401c887ff$087fc2a0$016ffea9@alphajay>
Message-ID: <Pine.LNX.4.58.0803180908270.1963@vlab.hofr.at>
References: <017e01c887fe$41395b20$016ffea9@alphajay>
	<018401c887ff$087fc2a0$016ffea9@alphajay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
