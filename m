Return-Path: <lists@gate-nine.de>
Received: from csmtp3.one.com (csmtp3.one.com [91.198.169.23])
	by ozlabs.org (Postfix) with ESMTP id 1FE27B6FAA
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jun 2011 21:03:32 +1000 (EST)
Message-ID: <4DFB329A.7010104@gate-nine.de>
Date: Fri, 17 Jun 2011 12:55:22 +0200
From: Philipp Ittershagen <lists@gate-nine.de>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Changes to of_device ?
References: <201106171119.48178.dargaud@lpsc.in2p3.fr>
In-Reply-To: <201106171119.48178.dargaud@lpsc.in2p3.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2011 11:19 AM, Guillaume Dargaud wrote:
> [I'm on the latest Xilinx tree, FWIW, so that's 2.6.25 still ?]

Not answering your primary question here, but in order to print the most
recent tag (along with a uniqe suffix, see man page) that is reachable
from your current branch, you can use "git describe". It will print out
the kernel version on your latest Xilinx tree.


Greetings,

  Philipp
