Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id C872BB8567
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:31:42 +1100 (EST)
Date: Thu, 11 Mar 2010 10:28:22 -0800
From: Greg KH <gregkh@suse.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 12/37] drivers/usb: use .dev.of_node instead of .node
	in struct of_device
Message-ID: <20100311182822.GA1950@suse.de>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180453.4824.61269.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100311180453.4824.61269.stgit@angua>
Cc: alsa-devel@alsa-project.org, sfr@canb.auug.org.au, monstr@monstr.eu,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	broonie@opensource.wolfsonmicro.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jeremy.kerr@canonical.com,
	linuxppc-dev@ozlabs.org, James.Bottomley@suse.de,
	linux-i2c@vger.kernel.org, ben-linux@fluff.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	jgarzik@pobox.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 11, 2010 at 11:04:54AM -0700, Grant Likely wrote:
> .node is being removed
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
