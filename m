Return-Path: <scarayol@assystembrime.com>
Received: from srv_courtaboeuf.brime.fr (unknown [81.255.87.178])
	by ozlabs.org (Postfix) with ESMTP id 9E9F767A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 20:00:43 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFF0E6C961.C5D53940-ONC1256FC7.002D9E1C@brime.fr>
From: scarayol@assystembrime.com
Date: Thu, 17 Mar 2005 09:51:07 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Subject: mapping large amount of memory on physical addresses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

Could you help me : I work on embedded Linux on a MPC885 processor
(PowerPC). On my embedded system, i have 2 different components of RAM.=
 One
(name =3D DV, total size of 256 MB ) is only accessed by the processor,=
 the
other (name =3D MC, size =3D 2MB on the top of the RAM) is also access =
by an
FPGA. I want to do data transferts between each others. For that, I hav=
e to
allocate a big structure on DV for a size of 36 MB.
- Could I do like that to have contiguous memory on DV ?
For MC, it would be more complicated : I have to map on the physical
adresses of MC (for example 1300 0000-13FF FFFF) in order to be sure th=
at
the memory will be really allocated on MC and not on DV (as there is en=
ough
place on DV).
- How can I do that ?
- Do I have to write a driver and use ioremap on the physical address o=
f MC
(with reserving the top of memory with 'mem=3D' at boot time) ? Can i u=
se
physical addresses with ioremap or is it only virtual addresses ?
I think i can reserve the memory early in boot via the bootmem allocato=
r
but i think it isn't with physical addresses only an amount of memory a=
nd
it's only forbdrivers directly linked in  the kernel image and i want a=

module.
- Is there another solution to do that ?

Thank you really for your help.

Best regards.

----------------------------------------------------------
Sophie CARAYOL

TECHNOLOGIES & SYSTEMES
50 rue du Pr=E9sident Sadate
F - 29337 QUIMPER CEDEX

T=E9l: +33 2 98 10 30 06
mailto:scarayol@assystembrime.com
----------------------------------------------------------
=
