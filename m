Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by ozlabs.org (Postfix) with ESMTP id E540467A39
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 00:21:50 +1100 (EST)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'Peter Mendham'" <petermendham@computing.dundee.ac.uk>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE : Kernel Panic During Linux Boot on ML405
Date: Thu, 30 Nov 2006 14:21:43 +0100
Message-ID: <000001c71482$7d8ff980$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <456ECDE9.2060506@computing.dundee.ac.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,
 Is there system ace interface in your hardware?
Your kernel boot command is=20
console=3Dttl0 root=3D/dev/xsysace/disc0/part2 rw ip=3Doff

so thta after kernel start it will look for any init file ine the root
file system suppose to be on /dev/xsysace/disc0/part2

regards

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
<----> part de Peter Mendham
<----> Envoy=E9=A0: jeudi 30 novembre 2006 13:26
<----> =C0=A0: linuxppc-embedded@ozlabs.org
<----> Objet=A0: Kernel Panic During Linux Boot on ML405
<---->=20
<----> I'm trying to make an uber-simple system on an ML405 board.  I
used
<----> the
<----> BSB to create a straight forward system with a PPC, DDR RAM,
<----> opb_ethernet, a uartlite, and pretty much nothing else.  The BSB
<----> threw
<----> in an interrupt controller, some DCMs and some bridges for me.
<----> That's
<----> all I have hardware-wise.  I compiled a 2.4.26 kernel because
I've
<----> had
<----> one working already on the default hardware setup.  I chose what
I
<----> think
<----> is the right options for the kernel, I've cut pretty much
everything
<----> out
<----> that I don't need.  The BSP the EDK generated was *extremely*
<----> lacking.
<----> It only generated an xparameters_ml300.h (no other files) which
was
<----> missing all the redefines.  I added these in myself by hand (this
may
<----> be
<----> the cause of my woes).  A boot log is given below.  I would
<----> appreciate
<----> any tips that anyone can give me.  Where should I start looking?
<---->=20
<----> Thanks in advance,
