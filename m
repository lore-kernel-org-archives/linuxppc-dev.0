Return-Path: <galak@kernel.crashing.org>
Message-Id: <21A85C7E-9288-4AFA-9448-09EEB61AAB52@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <1212753006-994-4-git-send-email-wg@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v4 3/4] [POWERPC] 85xx: support for the TQM8548 module
	using the big Flash
Date: Tue, 10 Jun 2008 11:07:49 -0500
References: <1212753006-994-1-git-send-email-wg@grandegger.com>
	<1212753006-994-2-git-send-email-wg@grandegger.com>
	<1212753006-994-3-git-send-email-wg@grandegger.com>
	<1212753006-994-4-git-send-email-wg@grandegger.com>
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

> Some TQM85xx boards could be equipped with up to 1 GiB (NOR) flash
> memory and therefore a modified memory map is required and setup by
> the board loader. This patch adds an appropriate DTS file.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm8548-bigflash.dts |  365 +++++++++++++++++++ 
> ++++++++++
> 1 file changed, 365 insertions(+)
> create mode 100644 arch/powerpc/boot/dts/tqm8548-bigflash.dts


applied.

- k
