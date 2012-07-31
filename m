Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B14662C008A
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2012 00:54:05 +1000 (EST)
Subject: Re: [PATCH] dma/fsldma: fix a compilation warnings
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BCB48C05FCE8BC4D9E61E841ECBE6DB70C5FA7@039-SN2MPN1-011.039d.mgd.msft.net>
Date: Tue, 31 Jul 2012 09:53:09 -0500
Message-Id: <C8EF4B7E-C0A9-4CEA-8978-02CA8912ACE0@kernel.crashing.org>
References: <1343743058-8013-1-git-send-email-galak@kernel.crashing.org>
 <BCB48C05FCE8BC4D9E61E841ECBE6DB70C5FA7@039-SN2MPN1-011.039d.mgd.msft.net>
To: Liu Qiang-B32616 <B32616@freescale.com>
Cc: "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 31, 2012, at 9:48 AM, Liu Qiang-B32616 wrote:

> Hi Kumar,
> ________________________________________
>> From: Linuxppc-dev =
[linuxppc-dev-bounces+qiang.liu=3Dfreescale.com@lists.ozlabs.org] on =
behalf of Kumar Gala [galak@kernel.crashing.org]
>> Sent: Tuesday, July 31, 2012 8:57 AM
>> To: dan.j.williams@intel.com
>> Cc: vinod.koul@intel.com; linuxppc-dev@ozlabs.org
>> Subject: [PATCH] dma/fsldma: fix a compilation warnings
>=20
>> drivers/dma/fsldma.c: In function 'fsl_dma_tx_submit':
>> drivers/dma/fsldma.c:409:15: warning: 'cookie' may be used =
uninitialized in this function
>>=20
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> drivers/dma/fsldma.c |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
>> index 8f84761..6194eb7 100644
>> --- a/drivers/dma/fsldma.c
>> +++ b/drivers/dma/fsldma.c
>> @@ -406,7 +406,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct =
dma_async_tx_descriptor *tx)
>>      struct fsl_desc_sw *desc =3D tx_to_fsl_desc(tx);
>>      struct fsl_desc_sw *child;
>>       unsigned long flags;
>> -       dma_cookie_t cookie;
>> +       dma_cookie_t cookie =3D 0;
> I have already submitted a patch to fix it. Please refer to:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2012-July/099819.html
>=20
> Thanks.

Ah, good.. missed it ;)

- k=
