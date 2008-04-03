Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 9F316DDF62
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 23:00:18 +1100 (EST)
Message-ID: <47F4C6A4.2020307@ru.mvista.com>
Date: Thu, 03 Apr 2008 15:59:32 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH 2/3][POWERPC][V2] Xilinx: of_serial support for Xilinx
	uart	16550.
References: <689CB232690D8D4E97DA6C76DA098E6C05FC4762@XCO-EXCHVS1.xlnx.xilinx.com>
	<20080402213919.C261F5E007F@mail91-dub.bigfish.com>
In-Reply-To: <20080402213919.C261F5E007F@mail91-dub.bigfish.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: John Linn <linnj@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Stephen Neuendorffer wrote:

> I don't think big-endian has the same context as reg-shift/reg-offset.

    The "big-endian" is about how the byte addresses are laid out, so the 
context is the same -- in this case, it would determine where each UART 
register is located within the address stride specified by "reg-shift".
It'll alwaay be at offset 0 or (2 << reg-shift) - 1 (unless some vendor goes 
and implements something with "middle-endian" layout of course :-)

> The OpenPOC is fundamentally a 32 bit device, but ns16550 is not...  If

    So what?

> we were talking about a 32 bit device, then I'd probably agree with you,

    There are 16550 clones that *are* 32-bit.

> but in this case, the reg-shift

    I'm not arguing about "reg-shift" already -- look like it's been spec'ed. :-)

> (and to some extent) reg-offset have
> been used before and probably make more sense, I think.

    The "reg-offset" has been used before? Where?

> Steve

WBR, Sergei
