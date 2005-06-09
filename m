Return-Path: <GARCIAJ@3il.fr>
Received: from email.3il.fr (email.3il.fr [195.25.243.230])
	by ozlabs.org (Postfix) with ESMTP id A9A02679A6
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Jun 2005 19:32:17 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Thu, 9 Jun 2005 11:28:05 +0200
Message-ID: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B32@exnet.3il.fr>
From: =?iso-8859-1?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <jeff@theptrgroup.com>
Cc: linuxppc-dev@ozlabs.org
Subject: RE : PPC arch and spinlocks
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

First of all,tks Jeff for this link.=20
So reading that, I understood that I need to enable the SMP support in =
the makemenuconfig
in order to use spinlocks even if I'm working on UP platform.
That's what I did but I now go through compile errors (I'm using a =
montavista PE 3.1):

In file included from =
/myWorks/en-cours/linux-2.4.20_mvl31/include/linux/smp.h:14,
                 from ppc4xx_setup.c:34:
/myWorks/en-cours/linux-2.4.20_mvl31/include/asm/smp.h:28: error: =
`NR_CPUS' undeclared here (not in a function)
/myWorks/en-cours/linux-2.4.20_mvl31/include/asm/smp.h:30: error: =
`NR_CPUS' undeclared here (not in a function)
/myWorks/en-cours/linux-2.4.20_mvl31/include/asm/smp.h:31: error: =
`NR_CPUS' undeclared here (not in a function)
/myWorks/en-cours/linux-2.4.20_mvl31/include/asm/smp.h:31: embrouill=E9 =
par les erreurs pr=E9c=E9dentes, abandon
make[1]: *** [ppc4xx_setup.o] Erreur 1
make[1]: Quitte le r=E9pertoire =
`/myWorks/en-cours/linux-2.4.20_mvl31/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Erreur 2

Is it a known problem for the montavista ppc users??

-------- Message d'origine--------
De: Jeff Angielski [mailto:jeff@theptrgroup.com]
Date: mer. 08/06/2005 17:26
=C0: Garcia J=E9r=E9mie
Cc: linuxppc-dev@ozlabs.org
Objet : Re: PPC arch and spinlocks
=20
On Wed, 2005-06-08 at 16:29 +0200, Garcia J=E9r=E9mie wrote:
> Hi everybody, I need your help one more time.
> I'm new to kernel device driver (linux newbie) and I'd like to control =
concurrent access
> to our hardware resources. (I'm working on a ppc405EP platform =
uniprocessor)

You might find this guide useful:

http://www.kernelnewbies.org/documents/kdoc/kernel-locking/lklockingguide=
.html



Jeff Angielski
The PTR Group
