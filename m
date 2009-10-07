Return-Path: <rob@landley.net>
From: Rob Landley <rob@landley.net>
To: devicetree-discuss@lists.ozlabs.org
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Date: Wed, 7 Oct 2009 02:09:58 -0500
References: <20091007041007.16890.62194.stgit@angua>
	<fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
In-Reply-To: <fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200910070209.59311.rob@landley.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 06 October 2009 23:49:04 Grant Likely wrote:
>
> However, I've completely devoted to this work for at least the next
> two months, so there are plenty more patches to follow.  Once I've
> got all the common code merged between Microblaze, PowerPC and Sparc
> I'll be fix the endian problems and making it easily usable by other
> architectures like ARM and MIPS.  Lots of work to be done.

Is there any news on getting QEMU to parse a device tree to figure out what 
hardware to emulate?  (I.E. using the device tree code to let qemu provide 
configurable board emulations instead of hardwiring them in C code?)

Also, what would be involved in getting x86 to (at least have the option to) 
use the device tree stuff?

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
