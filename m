Return-Path: <tur@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7533DDDE9F
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 19:30:13 +1100 (EST)
Message-ID: <47DF75E5.9000800@semihalf.com>
Date: Tue, 18 Mar 2008 08:57:25 +0100
From: Bartlomiej Sieka <tur@semihalf.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-mpc52xx.git
References: <fa686aa40802232335k24729c0fm6f643d06cccaf087@mail.gmail.com>	
	<47DE94F4.90804@semihalf.com>
	<fa686aa40803171219s7135a0f8n91bcd20329a94637@mail.gmail.com>
In-Reply-To: <fa686aa40803171219s7135a0f8n91bcd20329a94637@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Mon, Mar 17, 2008 at 9:57 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
[...]
>>  we were hoping that the changes would go upstream (in 2.6.25). I can see
>>  that the .dts files for those boards are in the mainline already, but I
>>  see no trace of for example _defconfig files -- could you shed some
>>  light on this?
> 
> Yes, the separate dts files have been dropped in preference for a
> single mpc5200_defconfig for all 5200 boards.

Ah, yes. I was searching for patches by Marian, and missed the defconfig
unification patch by you. BTW: I can't find it using its description 
from the commit log (i.e., "[POWERPC] mpc5200: merge defconfigs for all 
mpc5200 boards") in Nabble's archive of linuxppc ML; searching 
patchwork.ozlabs.org/linuxppc fails as well. Should I search
using some other description?

Regards,
Bartlomiej
