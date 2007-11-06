Return-Path: <mgreer@mvista.com>
Date: Mon, 5 Nov 2007 18:59:17 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] powerpc: prpmc2800 - Don't trust documented memory size
Message-ID: <20071106015917.GA28759@mag.az.mvista.com>
References: <20071106012805.GA20909@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071106012805.GA20909@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 05, 2007 at 06:28:05PM -0700, Mark A. Greer wrote:
> It turns out that the firmware on some PrPMC2800 processor modules
> initializes the memory controller for 512 MB even when there is more
> memory.  As a simple work around, set the amount of memory in the
> device tree passed to the kernel to the lesser of what the memory
> controller is set up for and the actual amount of memory.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> ---

Paul, please ignore this patch.  There is still something wrong.

Sorry for the noise.

Mark
