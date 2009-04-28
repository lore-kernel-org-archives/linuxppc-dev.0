Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2EB57DDED7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Apr 2009 02:06:01 +1000 (EST)
Message-Id: <982CAD05-5F4A-4A33-B991-16162CFFE1D8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
In-Reply-To: <20090428144814.GA14926@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: minimizing the configuration of
	linkstation_defconfig
Date: Tue, 28 Apr 2009 09:54:27 -0500
References: <20090424065816.GA15525@ime.usp.br>
	<Pine.LNX.4.64.0904242158210.8309@axis700.grange>
	<20090424223355.GB7858@ime.usp.br>
	<2CE2BC61-1C6B-4D01-870B-BC460730AD79@kernel.crashing.org>
	<20090428022711.GA30538@ime.usp.br>
	<F78629F9-59D2-4974-8461-06B7FAC2625D@kernel.crashing.org>
	<20090428144814.GA14926@ime.usp.br>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2009, at 9:48 AM, Rog=E9rio Brito wrote:

> On Apr 28 2009, Kumar Gala wrote:
>> I'm pretty sure we need this for old initrd style ramdisks so I'd =20
>> prefer
>> we leave it enabled.
>
> Oh, for oldstyle it is needed. You're right. It is better to keep it =20=

> in
> the defconfig. Just drop the hunk from the patch that I sent you.

just send a new patch w/this fixed.

- k=
