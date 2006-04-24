Return-Path: <Josef.Angermeier@informatik.uni-erlangen.de>
Received: from max72.rrze.uni-erlangen.de (max72.rrze.uni-erlangen.de
	[131.188.3.69]) by ozlabs.org (Postfix) with ESMTP id EC480679EF
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Apr 2006 22:07:21 +1000 (EST)
Received: from fau-vscan-2.rrze.uni-erlangen.de ([131.188.3.69]
	[131.188.3.69]) by faurelaysmart-2.rrze.uni-erlangen.de with
	ESMTP for linuxppc-embedded@ozlabs.org;
	Mon, 24 Apr 2006 14:07:08 +0200
Received: from max72.rrze.uni-erlangen.de ([131.188.3.69])
	by fau-vscan-2.rrze.uni-erlangen.de (fau-vscan-2.rrze.uni-erlangen.de
	[131.188.2.92]) (amavisd-new)
	with ESMTP id 28680-07 for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Apr 2006 14:07:08 +0200 (MEST)
Received: from [131.188.51.43] ([131.188.51.43] [131.188.51.43]) by
	smtp-auth.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Mon, 24 Apr 2006 14:06:34 +0200
Message-Id: <444CBF49.1040408@cs.fau.de>
Date: Mon, 24 Apr 2006 14:06:33 +0200
From: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: linux 2.4.25: loading usbcore.o gives segmentation fault
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

I am using linux 2.4.25 for a custom MPC875 based board. When adding 
general usb support as module (-> usbcore.o), loading usbcore.o gives a 
segmentation fault.,  while compiling it builtin seems to work. How can 
i find out what could be the reasons for that ?

thanks in advance, best regards
Josef
