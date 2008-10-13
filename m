Return-Path: <rbrito@ime.usp.br>
Received: from smtp.gru.flash.tv.br (smtp.flash.net.br [201.46.240.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 246BFDE14D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 07:56:57 +1100 (EST)
In-Reply-To: <20081013184443.GA20612@ld0162-tx32.am.freescale.net>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <66BF36BF-E218-4F2C-BE98-2A84E1E98C0D@ime.usp.br>
From: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
Date: Mon, 13 Oct 2008 18:56:38 -0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Scott, Guennadi.

On 13/10/2008, at 16:44, Scott Wood wrote:

> On Mon, Oct 13, 2008 at 08:05:09PM +0200, Guennadi Liakhovetski wrote:
>> On Mon, 13 Oct 2008, Rog=E9rio Brito wrote:
>>
>>> The current defconfig for Linkstation/Kuroboxes has the "Disable =20
>>> Heap
>>> Randomization" option enabled.
>>>
>>> Since some of these machines are facing the internet, it helps to =20=

>>> have
>>> heap randomization enabled. This patch enables it.
>>
>> Same as the previous patch - this is one of options, that users =20
>> select
>> according to their needs. If any specific distribution enables =20
>> this option
>> by default in their kernels, they can do this too, don't think =20
>> this is
>> critical enough to patch the defconfig.

I think that the matter is not being critical or not, but of =20
including a sane default as the kernel should be a place for best-=20
current-practices.

> Just because users/distros can change it doesn't mean it's =20
> pointless to
> discuss what default is sane, and make changes if the current default
> isn't.

Exactly my point.

> For security-related options it's usually best to default to the more
> secure state, especially since the option description talks about it
> being needed mainly for libc5 compatibility -- did libc5 ever even =20
> exist
> for powerpc?

I don't know, but even Debian's very ancient distributions all came =20
with libc6 on powerpc.

> The only reason it was turned on in the first place was likely the
> "default y", which in turn is there to avoid breaking old x86 distros.

Exactly. Agreed 100%.


Regards, Rog=E9rio Brito.

--=20
Rog=E9rio Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
