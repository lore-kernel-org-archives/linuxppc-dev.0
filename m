Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18154.32614.502824.264341@cargo.ozlabs.ibm.com>
Date: Fri, 14 Sep 2007 22:32:38 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 22/22] [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE,
	register mmc_spi stub
In-Reply-To: <11897177143496-git-send-email-galak@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
	<1189717691261-git-send-email-galak@kernel.crashing.org>
	<11897176931664-git-send-email-galak@kernel.crashing.org>
	<118971769498-git-send-email-galak@kernel.crashing.org>
	<11897176964013-git-send-email-galak@kernel.crashing.org>
	<11897176992010-git-send-email-galak@kernel.crashing.org>
	<11897177013875-git-send-email-galak@kernel.crashing.org>
	<11897177032288-git-send-email-galak@kernel.crashing.org>
	<11897177042582-git-send-email-galak@kernel.crashing.org>
	<11897177052448-git-send-email-galak@kernel.crashing.org>
	<11897177071168-git-send-email-galak@kernel.crashing.org>
	<11897177091972-git-send-email-galak@kernel.crashing.org>
	<11897177102281-git-send-email-galak@kernel.crashing.org>
	<1189717711656-git-send-email-galak@kernel.crashing.org>
	<11897177132273-git-send-email-galak@kernel.crashing.org>
	<11897177143496-git-send-email-galak@kernel.crashing.org>
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

> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> mmc_spi already tested to work. When it will hit mainline
> the only change that will be needed is replacing "spidev"
> with "mmc_spi".

That's a *remarkably* uninformative commit message.  And what's the
use of putting in something about "when it will hit mainline" when
this is the point where it hits mainline?

Paul.
