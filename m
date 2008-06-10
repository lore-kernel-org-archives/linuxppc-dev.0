Return-Path: <galak@kernel.crashing.org>
Message-Id: <0178FBA0-E456-473A-8FD6-694F2FFE3BAB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <1212753006-994-3-git-send-email-wg@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v4 2/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
Date: Tue, 10 Jun 2008 11:07:38 -0500
References: <1212753006-994-1-git-send-email-wg@grandegger.com>
	<1212753006-994-2-git-send-email-wg@grandegger.com>
	<1212753006-994-3-git-send-email-wg@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 6, 2008, at 6:50 AM, Wolfgang Grandegger wrote:

> This patch adds support for the TQM8548 modules from TQ-Components
> GmbH (http://www.tqc.de).
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/Makefile                  |    1
> arch/powerpc/boot/dts/tqm8548.dts           |  365 +++++++++
> arch/powerpc/boot/wrapper                   |    2
> arch/powerpc/configs/85xx/tqm8548_defconfig | 1094 ++++++++++++++++++ 
> ++++++++++
> arch/powerpc/platforms/85xx/Kconfig         |    8
> arch/powerpc/platforms/85xx/tqm85xx.c       |   15
> 6 files changed, 1482 insertions(+), 3 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/tqm8548.dts
> create mode 100644 arch/powerpc/configs/85xx/tqm8548_defconfig


applied.

- k
