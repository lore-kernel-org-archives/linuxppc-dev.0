Return-Path: <sshtylyov@mvista.com>
Received: from mail-ew0-f226.google.com (mail-ew0-f226.google.com
	[209.85.219.226]) by ozlabs.org (Postfix) with ESMTP id 2996FB81F7
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:33:30 +1100 (EST)
Received: by ewy26 with SMTP id 26so176165ewy.23
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:33:28 -0800 (PST)
Message-ID: <4B9936F2.3020105@ru.mvista.com>
Date: Thu, 11 Mar 2010 21:31:14 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 21/37] drivers/ata: use .dev.of_node instead of .node
	in	struct of_device
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180543.4824.70491.stgit@angua>
In-Reply-To: <20100311180543.4824.70491.stgit@angua>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello.

Grant Likely wrote:

> .node is being removed
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>
>  drivers/ata/pata_macio.c       |    2 +-
>  drivers/ata/pata_of_platform.c |    2 +-
>  drivers/ide/pmac.c             |   10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>   

   Should probably have been 2 patches instead of one, as drivers/ata/ 
and drivers/ide/ are different subsystems...

MBR, Sergei
