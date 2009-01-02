Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910901011933s3b353ddw753aca32635b5db@mail.gmail.com>
Date: Thu, 1 Jan 2009 22:33:01 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Section mismatches in the pcibios code
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

What's up with these section mismatches? I tried fixing them be they
are very intertwined.

  LD      arch/powerpc/kernel/built-in.o
WARNING: arch/powerpc/kernel/built-in.o(.text+0x11efc): Section
mismatch in reference from the function
pcibios_allocate_bus_resources() to the function
.init.text:reparent_resources()
The function pcibios_allocate_bus_resources() references
the function __init reparent_resources().
This is often because pcibios_allocate_bus_resources lacks a __init
annotation or the annotation of reparent_resources is wrong.

WARNING: arch/powerpc/kernel/built-in.o(.text+0x11fa4): Section
mismatch in reference from the function pcibios_finish_adding_to_bus()
to the function .devinit.text:pcibios_claim_one_bus()
The function pcibios_finish_adding_to_bus() references
the function __devinit pcibios_claim_one_bus().
This is often because pcibios_finish_adding_to_bus lacks a __devinit
annotation or the annotation of pcibios_claim_one_bus is wrong.

-- 
Jon Smirl
jonsmirl@gmail.com
