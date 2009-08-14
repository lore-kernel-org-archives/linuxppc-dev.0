Return-Path: <galak@kernel.crashing.org>
Message-Id: <9C37C203-DA22-48AE-AD2E-40D02F319F94@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <1250260574-13747-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH v2] sbc8560: Fix warm reboot with board specific reset
	function
Date: Fri, 14 Aug 2009 15:21:14 -0500
References: <1456507C-E9F9-436B-9901-6F127A5FDD1F@kernel.crashing.org>
	<1250260574-13747-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 14, 2009, at 9:36 AM, Paul Gortmaker wrote:

> From: Liang Li <Liang.Li@windriver.com>
>
> The existing fsl_rstcr_restart function is not applicable to the
> mpc8560. The Global Utilities Block on this earlier CPU doesn't have
> the control/reset register at 0xe00b0.  This implements a board
> specific reset function that uses the RCR(Reset Control Register) of
> the sbc8560's EPLD to do a reset.
>
> Signed-off-by: Liang Li <Liang.Li@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>
> v2: update comment, change outb(x, inb(x)&0x7f) --> clrbits(x,0x80)


applied to next

- k
