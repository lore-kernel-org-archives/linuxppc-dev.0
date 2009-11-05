Return-Path: <martyn.welch@gefanuc.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A987FB7BA8
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 01:26:24 +1100 (EST)
Message-ID: <4AF2DFC4.80307@gefanuc.com>
Date: Thu, 05 Nov 2009 14:23:00 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc/86xx: Enable NVRAM on GE Fanuc's SBC610
References: <20090702154928.31202.65107.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<20090702161231.31202.87763.stgit@ES-J7S4D2J.amer.consind.ge.com>
	<DAE90CFA-DC33-4BF6-9381-35B0BC1D45C4@kernel.crashing.org>
In-Reply-To: <DAE90CFA-DC33-4BF6-9381-35B0BC1D45C4@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Jul 2, 2009, at 11:12 AM, Martyn Welch wrote:
>
>> This patch enables the NVRAM found on the GE Fanuc SBC610
>>
>> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
>> ---
>>
>> arch/powerpc/boot/dts/gef_sbc610.dts           |    6 ++++++
>> arch/powerpc/configs/86xx/gef_sbc610_defconfig |    4 ++--
>> arch/powerpc/platforms/86xx/Kconfig            |    1 +
>> arch/powerpc/platforms/86xx/gef_sbc610.c       |    5 +++++
>> 4 files changed, 14 insertions(+), 2 deletions(-)
>
> I assume these still work w/the updates to the other patches?
>
> - k
I'm just updating your tree to ensure that the patches still apply (and 
compile) cleanly. I'm fairly confident that they will.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 927559189
