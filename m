Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17693.48925.252514.674193@cargo.ozlabs.ibm.com>
Date: Sat, 30 Sep 2006 10:49:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
In-Reply-To: <C62AC4D8-39E5-44D0-88A3-E8D8042FC828@kernel.crashing.org>
References: <4879B0C6C249214CBE7AB04453F84E4D19D866@zch01exm20.fsl.freescale.net>
	<C62AC4D8-39E5-44D0-88A3-E8D8042FC828@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> However, I'm not sure this really needs a node in the device tree.  
> The BCSR isn't really the same from board to board last time I  
> checked.  I'd be interested in Paul's thinking about why it should be  
> in the tree.

I just have a general preference for putting device addresses in the
device tree, because it increases the chance that you can reuse code
for multiple boards.  If the BCSR is always completely unique on every
board then there isn't so much of an argument for it, I agree.

Paul.
