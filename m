Return-Path: <rwoodworth@securics.com>
Received: from securics.com (unknown [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 9C397DDE11
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Aug 2007 06:34:41 +1000 (EST)
Subject: Re: [PATCH 2/3] Consolidate XILINX_VIRTEX board support.
From: Robert Woodworth <rwoodworth@securics.com>
To: wolfgang.reissnegger@xilinx.com
In-Reply-To: <20070822005049.12FE46F8069@mail8-cpk.bigfish.com>
References: <1187743993171-git-send-email-wolfgang.reissnegger@xilinx.com>
	<20070822005049.12FE46F8069@mail8-cpk.bigfish.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 14:34:38 -0600
Message-Id: <1187901278.6963.23.camel@PisteOff>
Mime-Version: 1.0
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 2007-08-21 at 17:53 -0700, wolfgang.reissnegger@xilinx.com
wrote:
> From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
> 
> Make support for Xilinx boards more generic, making it easier
> to add new boards.  ML300 and ML403 now use this.  Added
> CONFIG_XILINX_EMBED_CONFIG to do the consolidation, while still
> allowing boards not in the tree to avoid embed_config.
> 
I like it!

This is exactly what I'll use for my custom board.


RJW
