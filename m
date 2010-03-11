Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f186.google.com (mail-yx0-f186.google.com
	[209.85.210.186]) by ozlabs.org (Postfix) with ESMTP id 78EB2100BD5
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:26:08 +1100 (EST)
Received: by yxe16 with SMTP id 16so207816yxe.9
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:26:06 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100311.102347.169562565.davem@davemloft.net>
References: <20100311174830.4824.19820.stgit@angua>
	<20100311.102043.40590962.davem@davemloft.net>
	<20100311.102347.169562565.davem@davemloft.net>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Mar 2010 11:25:46 -0700
Message-ID: <fa686aa41003111025n7f059995v9263f13fac1bd1ee@mail.gmail.com>
Subject: Re: [PATCH 00/37] OF: move device node pointer into struct device.
To: David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: sfr@canb.auug.org.au, monstr@monstr.eu, broonie@opensource.wolfsonmicro.com,
	linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, gregkh@suse.de,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jeremy.kerr@canonical.com, linuxppc-dev@ozlabs.org,
	James.Bottomley@suse.de, linux-i2c@vger.kernel.org,
	ben-linux@fluff.org, microblaze-uclinux@itee.uq.edu.au,
	sparclinux@vger.kernel.org, akpm@linux-foundation.org,
	alsa-devel@alsa-project.org, jgarzik@pobox.com, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 11, 2010 at 11:23 AM, David Miller <davem@davemloft.net> wrote:
> From: David Miller <davem@davemloft.net>
> Date: Thu, 11 Mar 2010 10:20:43 -0800 (PST)
>
>> Three or four of the patches don't apply because only your tree
>> has those "/* temporary */" comments, f.e. in arch/sparc/kernel/pci.c
>>
>> I took care of this when applying to my tree.
>
> It also doesn't build, what the heck is this against
> Grant?
>
> drivers/of/device.c: In function 'of_match_device':
> drivers/of/device.c:24: error: 'const struct device' has no member named 'of_node'
> drivers/of/device.c:26: error: 'const struct device' has no member named 'of_node'
>
> Please make a patch set against Linus's vanilla tree so
> I and others can test this.

Oops, sorry David, I accidentally dropped the top patch.  Give me a
moment and I'll send it out.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
