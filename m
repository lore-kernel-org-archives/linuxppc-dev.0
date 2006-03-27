Return-Path: <Josef.Angermeier@informatik.uni-erlangen.de>
Received: from max72.rrze.uni-erlangen.de (max72.rrze.uni-erlangen.de
	[131.188.3.69]) by ozlabs.org (Postfix) with ESMTP id D605E679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 00:20:59 +1100 (EST)
Received: from fau-vscan-2.rrze.uni-erlangen.de ([131.188.3.69]
	[131.188.3.69]) by faurelaysmart-2.rrze.uni-erlangen.de with
	ESMTP for linuxppc-embedded@ozlabs.org;
	Mon, 27 Mar 2006 15:20:20 +0200
Received: from max72.rrze.uni-erlangen.de ([131.188.3.69])
	by fau-vscan-2.rrze.uni-erlangen.de (fau-vscan-2.rrze.uni-erlangen.de
	[131.188.2.92]) (amavisd-new)
	with ESMTP id 03369-02 for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Mar 2006 15:20:20 +0200 (MEST)
Received: from [131.188.51.43] ([131.188.51.43] [131.188.51.43]) by
	smtp-auth.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Mon, 27 Mar 2006 15:20:20 +0200
Message-Id: <4427E693.6060601@cs.fau.de>
Date: Mon, 27 Mar 2006 15:20:19 +0200
From: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: freescale 8xx: which architecture to use ? ppc - powerpc ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

i want to run linux (2.6.15) on my MPC875 board. I wonder which 
architecture to choose:  "powerpc" or "ppc" ? - menuconfig shows a 
"freescale 8xx" option when used with "powerpc", and a "8xx" option when 
used with ARCH=ppc. Because i use a embedded freescale 8xx i wanted to 
use the "powerpc" architecture. BUT: i seems to be unstable, i got some 
undefined referencies. Or am i wrong ?

thanks
Josef
