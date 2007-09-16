Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <1189940011134-git-send-email-tnt@246tNt.com>
References: <11899400103383-git-send-email-tnt@246tNt.com>
	<1189940011134-git-send-email-tnt@246tNt.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <684322B3-96A7-4867-8FA1-648E7ABCC7FF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/7] powerpc: BestComm core support for Freescale MPC5200
Date: Sun, 16 Sep 2007 11:07:52 -0500
To: Sylvain Munaut <tnt@246tNt.com>
Cc: Grant Likely <glikely@gmail.com>, Paul Mackerras <paulus@samba.org>,
	PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 16, 2007, at 5:53 AM, Sylvain Munaut wrote:

> This patch adds support for the core of the BestComm API
> for the Freescale MPC5200(b). The BestComm engine is a
> microcode-controlled / tasks-based DMA used by several
> of the onchip devices.
>
> Setting up the tasks / memory allocation and all common
> low level functions are handled by this patch.
> The specifics details of each tasks and their microcode
> are split-out in separate patches.
>
> This is not the official API, but a much cleaner one.
> (hopefully)
>
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> ---
>  arch/powerpc/platforms/Kconfig               |    2 +
>  arch/powerpc/sysdev/Makefile                 |    1 +
>  arch/powerpc/sysdev/bestcomm/Kconfig         |   18 +
>  arch/powerpc/sysdev/bestcomm/Makefile        |    8 +
>  arch/powerpc/sysdev/bestcomm/bestcomm.c      |  657 +++++++++++++++ 
> +++++++++++
>  arch/powerpc/sysdev/bestcomm/bestcomm.h      |  136 ++++++
>  arch/powerpc/sysdev/bestcomm/bestcomm_priv.h |  325 +++++++++++++
>  arch/powerpc/sysdev/bestcomm/sram.c          |  177 +++++++
>  arch/powerpc/sysdev/bestcomm/sram.h          |   54 +++
>  9 files changed, 1378 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/bestcomm/Kconfig
>  create mode 100644 arch/powerpc/sysdev/bestcomm/Makefile
>  create mode 100644 arch/powerpc/sysdev/bestcomm/bestcomm.c
>  create mode 100644 arch/powerpc/sysdev/bestcomm/bestcomm.h
>  create mode 100644 arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
>  create mode 100644 arch/powerpc/sysdev/bestcomm/sram.c
>  create mode 100644 arch/powerpc/sysdev/bestcomm/sram.h

this version still doesn't address comments made back in may:

http://ozlabs.org/pipermail/linuxppc-dev/2007-May/036224.html

Also, what about splitting bestcomm.c into bestcomm_task.c &  
bestcomm_drv.c (or just bestcomm.c) or something like that.  It seems  
'private API' isn't really the proper term.

- k
