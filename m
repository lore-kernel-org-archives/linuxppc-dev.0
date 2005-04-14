Return-Path: <jdubois@mc.com>
Received: from mc.com (iris-63.mc.com [63.96.239.141])
	by ozlabs.org (Postfix) with ESMTP id 261E367A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 20:27:09 +1000 (EST)
From: Jean-Christophe Dubois <jdubois@mc.com>
To: scarayol@assystembrime.com
In-Reply-To: <OFD3D0F6BD.3557C244-ONC1256FE3.0033B4B5@brime.fr>
References: <OFD3D0F6BD.3557C244-ONC1256FE3.0033B4B5@brime.fr>
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Apr 2005 12:09:56 +0200
Message-Id: <1113473397.27480.5.camel@fr-jdubois1.ad.mc.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: =?iso-8859-1?q?R=E9f=2E?= : RE: mmap : please help !
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Sophie,

On Thu, 2005-04-14 at 11:38 +0200, scarayol@assystembrime.com wrote:
> St=C3=A9phane,
>=20
> thanks for your help.
> But I think that, except instruction eieio,  I do similar things. You use
> the virtual address returned by mmap but have you the same values if you
> use write/read(axs_mem_fd,...) instead of in_8/out_8.
> That is  my problem : I want to be sure that when I use the virtual addre=
ss
> returned by mmap, I access really to the physical memory mapped area.

As the /dev/map_mc is your custom driver it should be fairly easy for
you to check the parameters you pass to remap_page_range().=20

> Do you know a shell command in order to dump the memory and verify what I
> do ?

try "od"

JC

> ----------------------------------------------------------
> Sophie CARAYOL
>=20
> TECHNOLOGIES & SYSTEMES
> 50 rue du Pr=C3=A9sident Sadate
> F - 29337 QUIMPER CEDEX
>=20
> T=C3=A9l: +33 2 98 10 30 06
> mailto:scarayol@assystembrime.com
> ----------------------------------------------------------
>=20
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
