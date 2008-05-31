Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18496.57794.862854.470430@cargo.ozlabs.ibm.com>
Date: Sat, 31 May 2008 15:27:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: galak@kernel.crashing.org
Subject: Re: [PATCH] Fix DMA nodes in the MPC8610 HPCD device tree
In-Reply-To: <1212185525-20944-1-git-send-email-timur@freescale.com>
References: <1212185525-20944-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi writes:

> The node for DMA2 in the MPC8610 HPCD device tree has the wrong compatible
> properties.  This breaks the DMA driver and the sound driver.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> I have no idea how I let this bug slip in, but this is a must-fix for 2.6.26.

Kumar, do you have anything else for 2.6.26 at the moment?  If not,
and this patch is OK with you, I'll put it in along with Olof's two
patches and send them to Linus.

Does anyone else have any pending fixes for 2.6.26?

Paul.
