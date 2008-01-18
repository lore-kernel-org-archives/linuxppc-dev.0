Return-Path: <Jogi95@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id 9F2C7DDE43
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 19:38:15 +1100 (EST)
Date: Fri, 18 Jan 2008 09:38:11 +0100
Message-Id: <541911165@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: r_wehbi@yahoo.fr
Subject: Re: array type has incomplete element type
Content-Type: text/plain; charset=iso-8859-15
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

Hi

I managed to set up linux for the ml310 (Virtex 2 pro) these days.
I don't know how similar it is, but here is what worked for me:
I used the kernel (newest 2.6.24-rc3) from the secret lab tree:
------------------------------------------------------------------
http://wiki.secretlab.ca/index.php/Linux=5Fon=5FXilinx=5FVirtex
--> look at vendow trees.
-------------------------------------------------------------------

I also used crosstool but with
gcc-3.4.5-glibc-2.3.6
maybe you give it a try

good Luck
Joachim
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220
