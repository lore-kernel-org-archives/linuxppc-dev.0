Return-Path: <sheflin@newagemicro.com>
Received: from server196.onecontrol.com (ip-66-129-110-196.name-host.com
	[66.129.110.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F50ADDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 10:12:13 +1100 (EST)
Date: Sun, 27 Jan 2008 18:05:06 -0500
To: linuxppc-embedded@ozlabs.org
From: Steve Heflin <sheflin@newagemicro.com>
Subject: Re: Reminder: removal of arch/ppc - (Sequoia)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Message-Id: <20080127231214.1F50ADDDE9@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The Sequoia board (AMCC-440EPx processor) is missing from the new 
arch/powerpc. The Sequoia board is also missing from arch/ppc , but 
there is support for integrated devices on the AMCC part inside 
arch/ppc that needs to be incorporated into arch/powerpc. In 
addition, there needs to be a "sequoia.c" file added to the 
arch/powerpc/44x directory.  I have a good start on the missing 
pieces and a test platform, is this contribution desired?

- Steve Heflin
   New Age Micro
   CEO & Software Engineer

At 11:55 AM 1/25/2008, you wrote:
>Just a reminder that the plan is to remove arch/ppc this summer (June
>2008).  The following boards still existing over in arch/ppc.  Some of
>them have been ported over to arch/powerpc.  If you care about one of
>these boards and its not ported speak up (it helps if you have access
>to the board).  Also, if you know a given board is free to die of
>bitrot let us know so we know not to worry about it:
>
>         PREP
>         PQ2ADS
>         TQM8260
>         CPCI690
>         EV64260
>         CHESTNUT
>         LOPEC
>         KATANA
>         HDPU
>         MVME5100
>         PAL4
>         POWERPMC250
>         PPLUS
>         PRPMC750
>         PRPMC800
>         RADSTONE_PPC7D
>         SANDPOINT
>         SBC82xx
>         SPRUCE
>         LITE5200
>         EV64360
>         MPC86XADS
>         MPC885ADS
>         ADS8272
>
>4xx:
>         BAMBOO
>         CPCI405
>         EBONY
>         EP405
>         BUBINGA
>         LUAN
>         YUCCA
>         OCOTEA
>         REDWOOD_5
>         REDWOOD_6
>         SYCAMORE
>         TAISHAN
>         WALNUT
>         XILINX_ML300
>         XILINX_ML403
>
>- k
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
