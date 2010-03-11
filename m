Return-Path: <jgpobox@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 34F4A1020F1
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:37:02 +1100 (EST)
Received: by gwj20 with SMTP id 20so183027gwj.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:37:01 -0800 (PST)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4B993847.3030100@pobox.com>
Date: Thu, 11 Mar 2010 13:36:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 21/37] drivers/ata: use .dev.of_node instead of .node
	in struct of_device
References: <20100311174830.4824.19820.stgit@angua>
	<20100311180543.4824.70491.stgit@angua>
	<4B9936F2.3020105@ru.mvista.com>
In-Reply-To: <4B9936F2.3020105@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: alsa-devel@alsa-project.org, gregkh@suse.de, linux-ide@vger.kernel.org,
	James.Bottomley@suse.de, linux-i2c@vger.kernel.org,
	sparclinux@vger.kernel.org, jeremy.kerr@canonical.com,
	sfr@canb.auug.org.au, linux-scsi@vger.kernel.org,
	microblaze-uclinux@itee.uq.edu.au,
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

On 03/11/2010 01:31 PM, Sergei Shtylyov wrote:
> Hello.
>
> Grant Likely wrote:
>
>> .node is being removed
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> ---
>>
>> drivers/ata/pata_macio.c | 2 +-
>> drivers/ata/pata_of_platform.c | 2 +-
>> drivers/ide/pmac.c | 10 +++++-----
>> 3 files changed, 7 insertions(+), 7 deletions(-)
>
> Should probably have been 2 patches instead of one, as drivers/ata/ and
> drivers/ide/ are different subsystems...

Possibly, but these patches should go in via the OF tree anyway, so 
collecting ACKs should be sufficient.

	Jeff
