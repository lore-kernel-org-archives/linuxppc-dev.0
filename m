Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 16B3DB6EEF
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 02:15:12 +1000 (EST)
Subject: Re: [PATCH 2/3] powerpc: implement arch_setup_pdev_archdata
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100806014455.8cab0ae9.sfr@canb.auug.org.au>
Date: Thu, 5 Aug 2010 11:14:57 -0500
Message-Id: <462C7602-3D2F-4B85-9F4A-15D12B30B423@kernel.crashing.org>
References: <1281021347-1278-1-git-send-email-galak@kernel.crashing.org>
	<1281021347-1278-2-git-send-email-galak@kernel.crashing.org>
	<1281021347-1278-3-git-send-email-galak@kernel.crashing.org>
	<20100806014455.8cab0ae9.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, gregkh@suse.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 5, 2010, at 10:44 AM, Stephen Rothwell wrote:

> Hi Kumar,
>=20
> On Thu,  5 Aug 2010 10:15:46 -0500 Kumar Gala =
<galak@kernel.crashing.org> wrote:
>>=20
>> +static inline void arch_setup_pdev_archdata(struct platform_device =
*pdev)
>> +{
>> +	pdev->dev.dma_mask =3D &pdev->archdata.dma_mask;
>> +
>> +	return;
>> +}
>=20
> The blank line and "return;" don't add anything.

Will fix.

- k=
