Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 45CA5B6FD1
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Aug 2011 12:45:09 +1000 (EST)
From: Xie Shaohui-B21989 <B21989@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: RE: [PATCH] powerpc/85xx: fix memory controller compatible for edac
Date: Mon, 1 Aug 2011 02:44:53 +0000
Message-ID: <267A3B246C22C34A8E574051858E0770110F6C@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1311659193-694-1-git-send-email-Shaohui.Xie@freescale.com>
	<20110731040328.GK24334@ponder.secretlab.ca>
In-Reply-To: <20110731040328.GK24334@ponder.secretlab.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"avorontsov@mvista.com" <avorontsov@mvista.com>,
	Gala Kumar-B11780 <B11780@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"davem@davemloft.net" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of Grant Likely
>Sent: Sunday, July 31, 2011 12:03 PM
>To: Xie Shaohui-B21989
>Cc: linuxppc-dev@lists.ozlabs.org; Gala Kumar-B11780; mm-
>commits@vger.kernel.org; avorontsov@mvista.com; davem@davemloft.net;
>akpm@linux-foundation.org
>Subject: Re: [PATCH] powerpc/85xx: fix memory controller compatible for
>edac
>
>On Tue, Jul 26, 2011 at 01:46:33PM +0800, Shaohui Xie wrote:
>> compatible in dts has been changed, so driver need to update accordingly=
.
>>
>> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>> ---
>> apply for
>> http://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
>> 'next' branch.
>>
>>  drivers/edac/mpc85xx_edac.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
>> index 13f6cc5..94c064a 100644
>> --- a/drivers/edac/mpc85xx_edac.c
>> +++ b/drivers/edac/mpc85xx_edac.c
>> @@ -1253,7 +1253,7 @@ static struct of_device_id
>mpc85xx_mc_err_of_match[] =3D {
>>  	{ .compatible =3D "fsl,p1020-memory-controller", },
>>  	{ .compatible =3D "fsl,p1021-memory-controller", },
>>  	{ .compatible =3D "fsl,p2020-memory-controller", },
>> -	{ .compatible =3D "fsl,p4080-memory-controller", },
>> +	{ .compatible =3D "fsl,qoriq-memory-controller", },
>
>Are there any implementations in the field that depend on the p4080 value?
>

[Xie Shaohui] The 'p4080' is introduced by commit cd1542c8197

edac: mpc85xx: add support for new MPCxxx/Pxxxx EDAC controllers

Simply add proper IDs into the device table.


My patch intended for fix the compliance of dts and driver.



Best Regards,=20
Shaohui Xie
