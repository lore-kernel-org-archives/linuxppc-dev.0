Return-Path: <galak@kernel.crashing.org>
Message-Id: <D750E93D-310B-42F4-87BD-F1AF9068B0CD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20081001083141.18444.63918.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v3] powerpc: GE Fanuc's FPGA based PIC controller on the
	SBC610
Date: Fri, 3 Oct 2008 16:53:21 -0500
References: <20081001083141.18444.63918.stgit@ubuntu8041.localdomain>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 1, 2008, at 3:32 AM, Martyn Welch wrote:

> Support for the SBC610 VPX Single Board Computer from GE Fanuc  
> (PowerPC MPC8641D).
>
> A number of MPC8641D based route interrupts for on-board interrupts  
> through
> a FPGA based interrupt controller, which is chained with the
> MPC8641D's mpic. This patch provides a basic driver to allow basic  
> routing
> of interrupts to the mpic.
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> Scott, David: Thank you for your comments.
>
> Changes for version 3:
> * Remove redundant "device_type" entry from gef_pic node
> * Use 1 rather than 2 interrupt cells

applied.

- k
