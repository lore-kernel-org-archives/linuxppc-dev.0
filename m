Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5298CB6EF2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 18:01:08 +1100 (EST)
Subject: Re: [PATCH] edac: mpc85xx: Add support for new MPCxxx/Pxxxx EDAC
	controllers (fix)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0778A3B9-E242-4BCC-B318-154BE9ECB2C6@kernel.crashing.org>
Date: Thu, 7 Oct 2010 02:00:50 -0500
Message-Id: <4A00FECC-3840-45E1-AB2A-6BDBD0FE09E0@kernel.crashing.org>
References: <20100715182507.GA3482@oksana.dev.rtsoft.ru>
	<20100716151224.21d499a3@schlenkerla.am.freescale.net>
	<20100721153933.64d02086.akpm@linux-foundation.org>
	<20100721182108.5a22c822@schlenkerla.am.freescale.net>
	<20100801105419.GA352@oksana.dev.rtsoft.ru>
	<5628792F-9A5F-4200-90B3-FB3939F02969@kernel.crashing.org>
	<20101007062909.GA27110@oksana.dev.rtsoft.ru>
	<0778A3B9-E242-4BCC-B318-154BE9ECB2C6@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Doug Thompson <dougthompson@xmission.com>,
	linux-kernel@vger.kernel.org, Dave Jiang <djiang@mvista.com>,
	Peter Tyser <ptyser@xes-inc.com>, Scott Wood <scottwood@freescale.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 7, 2010, at 1:37 AM, Kumar Gala wrote:

>> @ -1125,7 +1128,10 @@ static struct of_device_id =
mpc85xx_mc_err_of_match[] =3D {
>> 	{ .compatible =3D "fsl,mpc8569-memory-controller", },
>> 	{ .compatible =3D "fsl,mpc8572-memory-controller", },
>> 	{ .compatible =3D "fsl,mpc8349-memory-controller", },
>> +	{ .compatible =3D "fsl,p1020-memory-controller", },
>> +	{ .compatible =3D "fsl,p1021-memory-controller", },
>> 	{ .compatible =3D "fsl,p2020-memory-controller", },
>> +	{ .compatible =3D "fsl,p4080-memory-controller", },
>=20
> This line should be here ;)

should NOT be here.

- k=
