Return-Path: <Jogi95@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id 2D050DDDF5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 21:03:57 +1100 (EST)
Received: from web.de
	by fmmailgate04.web.de (Postfix) with SMTP id 0121E44C9C03
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 11:03:55 +0100 (CET)
Date: Wed, 30 Jan 2008 11:03:54 +0100
Message-Id: <568740669@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: linuxppc-embedded@ozlabs.org
Subject: linux @ xup
Content-Type: text/plain; charset=iso-8859-15
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

I already succeded in setting up a Linux for the ml310. I'm trying to do it for the XUP Board now. The Problem I have is, that
in every HowTo I read I should set at the EDK's software settings under Library/OS Parameters:
Set PLB_CLOCK_FREQ_HZ to the PLB speed (usually 100000000)

But I can't find where to set it. With the ml310 there was this option. I'm using the EDK Board Definition File (.xbd), Pcores & Drivers from Xilinx:
http://www.xilinx.com/univ/xupv2p.html
EDK Version 9.1 SP2

If I ignore it and build the BSP there comes out an xparameters_ml300.h file which I copy to my Kernel sources.
When I try to compile, I get errors that the PLB_CLOCK_FREQ_HZ isn't defined.
Can I just add it to the xparameters_ml300.h file file (which I rename "xparameters_xupv2p.h") by Hand?

Greez and thx
Joachim
_________________________________________________________________________
In 5 Schritten zur eigenen Homepage. Jetzt Domain sichern und gestalten! 
Nur 3,99 EUR/Monat! http://www.maildomain.web.de/?mc=021114
