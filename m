Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id 6B61967B73
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 00:37:15 +1000 (EST)
To: Jean-Christophe Dubois <jdubois@mc.com>
Message-ID: <OF6D9DF5A3.572A1EAE-ONC1256FE3.004DDA93@brime.fr>
From: scarayol@assystembrime.com
Date: Thu, 14 Apr 2005 16:37:53 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Cc: linuxppc-embedded@ozlabs.org
Subject: =?iso-8859-1?q?R=E9f=2E_=3A_Re=3A_R=E9f=2E_=3A_RE=3A_mmap_=3A_pl?=
 =?iso-8859-1?q?ease_help?=  !
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello Jean-Christophe,

That's right, I verify all the useful parameters in my driver and
everything seems OK.
But, the real question is : if you use the /dev/mem (with open() and mm=
ap
()), could you use, in the user space, the pointer returned by the mmap=

function to access the physical memory or do you have to use read/write=
 (on
the file descriptor) to access physical memory because i haven't the sa=
me
results according to the used method.
Thanks for 'od' but i haven't in my packages.

Sophie.



                                                                       =
                                                                       =

                    Jean-Christop                                      =
                                                                       =

                    he Dubois            Pour :  scarayol@assystembrime=
.com                                                                   =

                    <jdubois@mc.c        cc :    linuxppc-embedded@ozla=
bs.org                                                                 =

                    om>                  Objet :      Re: R=E9f. : RE: =
mmap : please help !                                                   =
 =20
                                                                       =
                                                                       =

                    14/04/05                                           =
                                                                       =

                    12:09                                              =
                                                                       =

                                                                       =
                                                                       =

                                                                       =
                                                                       =




Hello Sophie,

On Thu, 2005-04-14 at 11:38 +0200, scarayol@assystembrime.com wrote:
> St=E9phane,
>
> thanks for your help.
> But I think that, except instruction eieio,  I do similar things. You=
 use
> the virtual address returned by mmap but have you the same values if =
you
> use write/read(axs_mem_fd,...) instead of in_8/out_8.
> That is  my problem : I want to be sure that when I use the virtual
address
> returned by mmap, I access really to the physical memory mapped area.=


As the /dev/map_mc is your custom driver it should be fairly easy for
you to check the parameters you pass to remap_page_range().

> Do you know a shell command in order to dump the memory and verify wh=
at I
> do ?

try "od"

JC

> ----------------------------------------------------------
> Sophie CARAYOL
>
> TECHNOLOGIES & SYSTEMES
> 50 rue du Pr=E9sident Sadate
> F - 29337 QUIMPER CEDEX
>
> T=E9l: +33 2 98 10 30 06
> mailto:scarayol@assystembrime.com
> ----------------------------------------------------------
>
>
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded



=
