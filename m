Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9115367B22
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jun 2005 01:20:08 +1000 (EST)
Message-ID: <42A85E19.5090800@am.sony.com>
Date: Thu, 09 Jun 2005 08:19:53 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: =?UTF-8?B?77+9?= <GARCIAJ@3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B32@exnet.3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B32@exnet.3il.fr>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
Subject: Re: RE : PPC arch and spinlocks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

� wrote:
> First of all,tks Jeff for this link. 
> So reading that, I understood that I need to enable the SMP support in
> the makemenuconfig
> in order to use spinlocks even if I'm working on UP platform.
> That's what I did but I now go through compile errors (I'm using a
> montavista PE 3.1):
> 
> In file included from
> /myWorks/en-cours/linux-2.4.20_mvl31/include/linux/smp.h:14,
>                  from ppc4xx_setup.c:34:
> /myWorks/en-cours/linux-2.4.20_mvl31/include/asm/smp.h:28: error:
> `NR_CPUS' undeclared here (not in a function)
> /myWorks/en-cours/linux-2.4.20_mvl31/include/asm/smp.h:30: error:
> `NR_CPUS' undeclared here (not in a function)
> /myWorks/en-cours/linux-2.4.20_mvl31/include/asm/smp.h:31: error:
> `NR_CPUS' undeclared here (not in a function)
> /myWorks/en-cours/linux-2.4.20_mvl31/include/asm/smp.h:31: embrouill�
> par les erreurs pr�c�dentes, abandon
> make[1]: *** [ppc4xx_setup.o] Erreur 1
> make[1]: Quitte le r�pertoire
> `/myWorks/en-cours/linux-2.4.20_mvl31/arch/ppc/kernel'
> make: *** [_dir_arch/ppc/kernel] Erreur 2
> 

ppc4xx core doesn't support SMP.
