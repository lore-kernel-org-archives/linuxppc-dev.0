Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77B8DB6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 22:17:43 +1000 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id
	p5HBMJcV028181
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2011 13:22:19 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Changes to of_device ?
Date: Fri, 17 Jun 2011 13:22:19 +0200
References: <201106171119.48178.dargaud@lpsc.in2p3.fr>
	<4DFB329A.7010104@gate-nine.de>
In-Reply-To: <4DFB329A.7010104@gate-nine.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106171322.19067.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Not answering your primary question here, but in order to print the most
> recent tag (along with a uniqe suffix, see man page) that is reachable
> from your current branch, you can use "git describe". It will print out
> the kernel version on your latest Xilinx tree.

$ git describe
v2.6.37-719-gecf08a4

$ cat ./include/linux/version.h
#define LINUX_VERSION_CODE 132645
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))

$ printf "%x\n" 132645
20625

Something doesn't quite match here... But my original question about how do you declare a probe function in the latest 
kernels still stand...
-- 
Guillaume Dargaud
http://www.gdargaud.net/
