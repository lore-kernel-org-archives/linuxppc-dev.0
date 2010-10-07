Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0EC6FB6F06
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:18:39 +1100 (EST)
Subject: Re: [PATCH] edac: mpc85xx: Add support for new MPCxxx/Pxxxx EDAC
	controllers (fix)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100801105419.GA352@oksana.dev.rtsoft.ru>
Date: Thu, 7 Oct 2010 01:18:19 -0500
Message-Id: <5628792F-9A5F-4200-90B3-FB3939F02969@kernel.crashing.org>
References: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
	<20100716151224.21d499a3@schlenkerla.am.freescale.net>
	<20100721153933.64d02086.akpm@linux-foundation.org>
	<20100721182108.5a22c822@schlenkerla.am.freescale.net>
	<20100801105419.GA352@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Dave Jiang <djiang@mvista.com>, Peter Tyser <ptyser@xes-inc.com>,
	Doug Thompson <dougthompson@xmission.com>,
	Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 1, 2010, at 5:54 AM, Anton Vorontsov wrote:

> On Wed, Jul 21, 2010 at 06:21:08PM -0500, Scott Wood wrote:
> [...]
>>>>> +	{ .compatible =3D "fsl,p4080-l2-cache-controller", },
>>>>=20
>>>> L2 on the p4080 is quite different from those other chips.  It's =
part
>>>> of the core, controlled by SPRs.
>>>=20
>>> erm, was that an ack or a nack?
>>=20
>> NACK, p4080 doesn't belong in this table, at least not its L2.
>>=20
>> L3 on p4080 is similar to L2 on these other chips, though, and it
>> wouldn't take much to get this driver working on it -- but the match
>> table entry should wait until the differences are accommodated.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
>=20
> Scott, thanks for catching this!
>=20
> Andrew, please merge this patch into
> edac-mpc85xx-add-support-for-new-mpcxxx-pxxxx-edac-controllers.patch
>=20
> Thanks!
>=20
> drivers/edac/mpc85xx_edac.c |    1 -
> 1 files changed, 0 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
> index cfa86f7..b178cfa 100644
> --- a/drivers/edac/mpc85xx_edac.c
> +++ b/drivers/edac/mpc85xx_edac.c
> @@ -652,7 +652,6 @@ static struct of_device_id =
mpc85xx_l2_err_of_match[] =3D {
> 	{ .compatible =3D "fsl,p1020-l2-cache-controller", },
> 	{ .compatible =3D "fsl,p1021-l2-cache-controller", },
> 	{ .compatible =3D "fsl,p2020-l2-cache-controller", },
> -	{ .compatible =3D "fsl,p4080-l2-cache-controller", },
> 	{},
> };
> MODULE_DEVICE_TABLE(of, mpc85xx_l2_err_of_match);
> --=20
> 1.7.0.5

Can you post a new patch as it doesn't look like this got merged by =
Andrew so we need to clean up after ourselves.

- k
