Return-Path: <galak@kernel.crashing.org>
Message-Id: <33882B0C-B5F9-4B75-B57C-C85CE2BFD615@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <1212753006-994-2-git-send-email-wg@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH v4 1/4] [POWERPC] 85xx: correct vendor prefix in DTS files
	for TQM85xx modules
Date: Tue, 10 Jun 2008 11:07:20 -0500
References: <1212753006-994-1-git-send-email-wg@grandegger.com>
	<1212753006-994-2-git-send-email-wg@grandegger.com>
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

> Like for the TQM5200, the vendor prefix "tqc," is now used for all
> TQM85xx modules from TQ-Components GmbH (http://www.tqc.de) in the
> corresponding DTS files.
>
> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
> ---
> arch/powerpc/boot/dts/tqm8540.dts     |    4 ++--
> arch/powerpc/boot/dts/tqm8541.dts     |    4 ++--
> arch/powerpc/boot/dts/tqm8555.dts     |    4 ++--
> arch/powerpc/boot/dts/tqm8560.dts     |    4 ++--
> arch/powerpc/platforms/85xx/tqm85xx.c |    8 ++++----
> 5 files changed, 12 insertions(+), 12 deletions(-)

applied.

- k
