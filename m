Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 703D4B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 15 Aug 2009 06:32:53 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C7FB5DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Aug 2009 06:32:52 +1000 (EST)
Message-Id: <D8CF2E8D-7CB4-43FE-9637-FD4512BE82A4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <22f17c810cb3e567a842300c553121a574d9b139.1250036189.git.paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH 2/4] Add localbus node and MTD partitions for SBC834x
Date: Fri, 14 Aug 2009 15:32:48 -0500
References: <1250084071-26418-1-git-send-email-paul.gortmaker@windriver.com>
	<87b9869d069308d2ed12324ea924e284c85a6765.1250036189.git.paul.gortmaker@windriver.com>
	<22f17c810cb3e567a842300c553121a574d9b139.1250036189.git.paul.gortmaker@windriver.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 12, 2009, at 8:34 AM, Paul Gortmaker wrote:

> From: Liang Li <liang.li@windriver.com>
>
> There is 8MB flash, 8kB EEPROM and 128MB SDRAM on the sbc834x
> local bus, so add a localbus node in DTS with MTD partitions.
>
> The recent U-boot commit fe613cdd4eb moves u-boot to the beginning
> of flash, hence the legacy label on the partition at the end of flash.
>
> Signed-off-by: Liang Li <liang.li@windriver.com>
> Signed-off-by: Yang Shi <yang.shi@windriver.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> arch/powerpc/boot/dts/sbc8349.dts |   40 ++++++++++++++++++++++++++++ 
> +++++++++
> 1 files changed, 40 insertions(+), 0 deletions(-)


applied to next

- k
