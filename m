Return-Path: <ml@iridescent.org>
Received: from mail.iridescent.org (adsl-63-193-117-152.dsl.snfc21.pacbell.net
	[63.193.117.152]) by ozlabs.org (Postfix) with SMTP id 2668A67A83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 18:20:05 +1100 (EST)
Mime-Version: 1.0
Message-Id: <p0621020ebe656d463a67@mail.iridescent.org>
In-Reply-To: <0.20050322_000905.tnt@patchsend.246tNt.com>
References: <0.20050322_000905.tnt@patchsend.246tNt.com>
Date: Mon, 21 Mar 2005 23:04:44 -0800
To: ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
From: "Lawrence E. Bakst" <ml@iridescent.org>
Content-Type: text/plain; charset="us-ascii"
Subject: Future of OCP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I apologize up front for my ignorance.

At 12:06 AM +0100 3/22/05, Sylvain Munaut wrote:
>Hi all,
>
>This series of patch changes all the MPC52xx related code
>to use platform bus and ppc_sys instead of OCP. It's
>divided in several patches that represents "steps" in
>the conversion. However the intermediate states might
>not be functionnal.
>
>This is the first try, comments and suggestions are
>welcomed.


At 9:35 AM -0600 1/18/05, Kumar Gala wrote:
>System platform_device description, discovery and management:
>
>On most embedded PPC systems we either have a core CPU and chipset
>(MPC10x, TSI10x, Marvell, etc.) or a system-on-chip device (4xx, 8xx,
>82xx, 85xx, etc.).  Some of these sub-archs have been using the On Chip
>Peripheral (OCP) driver model.  The functionality that OCP provide has
>been replaced by the generic driver model and platform_device.  Also, some
>of these device may exist across a number of architectures (PPC, MIPS,
>ARM) such that some information that is shared between the architecture
>and driver needs to exist outside of either.
>
>The ppc_sys changes add a standard way for PowerPC systems to describe the
>devices and systems that exist in the sub-arch.  Additionally, we are able
>to discover which system we are and manage which devices are actually
>registered and any platform specific fixups that may be needed.
>
>Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

Q1: OK, so I gather the OCP system which until recently used to be in a separate OCP tree and was recently integrated into 2.6 is going away?

I had just started to do a 405 EP port of 2.6.11-rc4  based off of the bubinga config.

Q2: Assuming yes, to Q1, any advice on how I should proceed, continue on with an OCP port or wait for this new stuff?

Q3: How does one stay in the loop on this stuff? With only about 3 messages posted in this group and none in linuxppc-dev I am clearly in the wrong place. I feel like I missed the conversation. Where was it?

Best,

leb
