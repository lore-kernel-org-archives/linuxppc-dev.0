Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 168FEB7D21
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Mar 2010 04:31:05 +1100 (EST)
Date: Fri, 12 Mar 2010 12:31:02 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 12/27] drivers/mtd/of: don't use deprecated field in
	of_platform_driver
Message-ID: <20100312123102.453ff2d0@lappy.seanm.ca>
In-Reply-To: <20100311182253.13103.92479.stgit@angua>
References: <20100311181604.13103.30088.stgit@angua>
	<20100311182253.13103.92479.stgit@angua>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, gregkh@suse.de, linux-ide@vger.kernel.org,
	James.Bottomley@suse.de, linux-i2c@vger.kernel.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com,
	sfr@canb.auug.org.au, linux-scsi@vger.kernel.org,
	jgarzik@pobox.com, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, ben-linux@fluff.org,
	monstr@monstr.eu, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, broonie@opensource.wolfsonmicro.com,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	dwmw2@infradead.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 11 Mar 2010 11:22:54 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> .name, .match_table and .owner are duplicated in both
> of_platform_driver and device_driver, so the of_platform_driver
> copies will be removed soon.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

NDFC
Acked-by: Sean MacLennan <smaclennan@pikatech.com>
