Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by ozlabs.org (Postfix) with ESMTP id 7E4FA67B52
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 02:08:24 +1100 (EST)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'Peter Mendham'" <petermendham@computing.dundee.ac.uk>
Subject: RE : RE : Kernel Panic During Linux Boot on ML405
Date: Thu, 30 Nov 2006 16:08:20 +0100
Message-ID: <000301c71491$6018cd00$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <456EEB35.1070907@computing.dundee.ac.uk>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

As far as I understand you try to start on Montavista root file system
(delivered with ML40x CompactFlash).

I think that the init procedure try to initialize keyboard as well as
mouse.

So its may be a track but I'm not sure about that.

You can tray to rename the /sbin/init file on the compact flash in
something like oldinit. The kernel should launch a bash if no init is
detected.

Regrads

chris

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
<----> Envoy=E9=A0: jeudi 30 novembre 2006 15:31
<----> Cc=A0: linuxppc-embedded@ozlabs.org
<----> Objet=A0: Re: RE : Kernel Panic During Linux Boot on ML405
<---->=20
<----> alayrac wrote:
<----> > Is there system ace interface in your hardware?
<----> >
<----> Yes, there is, configured as interrupt driven.  I missed that
from my
<----> list, sorry.
<----> -- Peter
<----> _______________________________________________
<----> Linuxppc-embedded mailing list
<----> Linuxppc-embedded@ozlabs.org
<----> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
