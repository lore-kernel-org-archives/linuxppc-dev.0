Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E5F1DE6C2
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 05:22:20 +1000 (EST)
Message-Id: <86DE8A00-E8B8-49A0-AC15-4085C00B3BB1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
In-Reply-To: <4899E2FE.6090709@exactcode.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: Big include file move breaks user mode
Date: Wed, 6 Aug 2008 14:21:17 -0500
References: <20080805120916.2f39307c@lappy.seanm.ca>	<200808061651.40361.arnd@arndb.de>
	<20080806110124.40280d13@lappy.seanm.ca>
	<4899E2FE.6090709@exactcode.de>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux-Embedded <linux-embedded@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 6, 2008, at 12:44 PM, Ren=E9 Rebe wrote:

>
> Heh, you might also consider using "off the shelf" build systems, such
> as the T2 SDE:
>
> http://t2-project.org
>
> To avoid re-inventing the wheel again and again.
>
> Yours,
>

Whee.. another rootfs build system.  Why we can't converge some of =20
these towards so we have a larger community is beyond me.

- k=
