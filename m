Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9EE99B7F38
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:31:45 +1100 (EST)
Date: Thu, 11 Mar 2010 10:28:52 -0800
From: Greg KH <gregkh@suse.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 05/27] drivers/usb/of: don't use deprecated field in
	of_platform_driver
Message-ID: <20100311182852.GB1950@suse.de>
References: <20100311181604.13103.30088.stgit@angua>
	<20100311182215.13103.45160.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100311182215.13103.45160.stgit@angua>
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

On Thu, Mar 11, 2010 at 11:22:15AM -0700, Grant Likely wrote:
> .name, .match_table and .owner are duplicated in both of_platform_driver
> and device_driver, so the of_platform_driver copies will be removed soon.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
