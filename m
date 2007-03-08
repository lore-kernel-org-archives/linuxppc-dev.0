Return-Path: <christophe.alayrac@cresitt.com>
Received: from postfix1-g20.free.fr (postfix1-g20.free.fr [212.27.60.42])
	by ozlabs.org (Postfix) with ESMTP id 75D57DDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Mar 2007 01:39:27 +1100 (EST)
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by postfix1-g20.free.fr (Postfix) with ESMTP id 33299B29F3D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Mar 2007 15:39:14 +0100 (CET)
Received: from CRESITTLAB (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp5-g19.free.fr (Postfix) with ESMTP id E63277DA7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Mar 2007 15:39:10 +0100 (CET)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE : Reset cause API
Date: Thu, 8 Mar 2007 15:39:10 +0100
Message-ID: <000501c7618f$89492bc0$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <3E32AE64-2BE2-4B74-8AEC-4A42AF888010@kernel.crashing.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

The PPC405 recognizes three types of reset:
=95 Aprocessor reset affects the processor only, including the execution
units and cache units. External devices (on-chip and off-chip) are not
affected. This type of reset is sometimes referred to as a core reset.
=95 Achip reset affects the processor and all other devices or =
peripherals
located on the same chip as the processor.
=95 Asystem reset affects the processor chip and all other devices or
peripherals external to the processor chip that are connected to the
same system-reset network. The scope of a system reset depends on the
system implementation.

The type of reset is recorded in the most-recent reset field of the
debug-status register (DBSR[MRR]). System software can examine this
field if it needs to determine the cause of a reset. The effect of a
reset on the processor is always the same regardless of the type.

For more details you can see ppc-ref-guide.pdf (in EDK doc directory).
Chris

CRESITT INDUSTRIE
12 Rue de Blois, BP6744
45067 ORLEANS Cedex 2
Tel : 02.38.49.45.59
Fax :02.38.49.45.55
Email : christophe.alayrac@cresitt.com=20
Web : http://www.cresitt.com


<----> -----Message d'origine-----
<----> De=A0: linuxppc-embedded-
<----> bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org
[mailto:linuxppc-
<----> embedded-bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org] De =
la
<----> part de Kumar Gala
<----> Envoy=E9=A0: jeudi 8 mars 2007 15:30
<----> =C0=A0: bwarren@qstreams.com
<----> Cc=A0: linuxppc-embedded@ozlabs.org
<----> Objet=A0: Re: Reset cause API
<---->=20
<---->=20
<----> On Mar 5, 2007, at 3:22 PM, Ben Warren wrote:
<---->=20
<----> > Hello,
<----> >
<----> > Is there an API call, either Linux or PowerPC-specific, for
<----> > determining
<----> > the cause of the last reset?  I can certainly read the RSR
myself,
<----> but
<----> > why bother if the information's available elsewhere.
<---->=20
<----> There isnt anything like this since we don't have any consistent
way
<----> of maintaining information across a reset.
<---->=20
<----> Something like kexec could possibly do something.
<---->=20
<----> - k
<----> _______________________________________________
<----> Linuxppc-embedded mailing list
<----> Linuxppc-embedded@ozlabs.org
<----> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
