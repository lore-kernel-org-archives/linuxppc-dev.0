Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49932DEDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:11:45 +1000 (EST)
Message-Id: <812E9035-65E7-461C-979E-A390F04E6EDC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080311172421.GD7727@localhost.localdomain>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 4/8] [POWERPC] immap_qe.h should include asm/io.h
Date: Mon, 14 Apr 2008 10:11:42 -0500
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172421.GD7727@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 11, 2008, at 12:24 PM, Anton Vorontsov wrote:
> Headers should include prototypes they use, otherwise build will
> break if we use it without explicitly including io.h:
>
>  CC      arch/powerpc/sysdev/qe_lib/gtm.o
> In file included from include/asm/qe.h:20,
>                 from arch/powerpc/sysdev/qe_lib/gtm.c:18:
> include/asm/immap_qe.h: In function =E2=80=98immrbar_virt_to_phys=E2=80=99=
:
> include/asm/immap_qe.h:480: error: implicit declaration of function =E2=20=

> =80=98virt_to_phys=E2=80=99
> make[2]: *** [arch/powerpc/sysdev/qe_lib/gtm.o] Error 1
> make[1]: *** [arch/powerpc/sysdev/qe_lib] Error 2
>
> gtm.c needs qe.h (which includes immap_qe.h) to use qe_get_brg_clk().
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> include/asm-powerpc/immap_qe.h |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)

applied.

- k
