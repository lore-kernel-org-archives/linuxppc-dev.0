Return-Path: <Josef.Angermeier@informatik.uni-erlangen.de>
Received: from max71.rrze.uni-erlangen.de (max71.rrze.uni-erlangen.de
	[131.188.3.181]) by ozlabs.org (Postfix) with ESMTP id 43D1867A0E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 17:46:07 +1000 (EST)
Received: from fau-vscan-1.rrze.uni-erlangen.de ([131.188.3.181]
	[131.188.3.181]) by faurelaysmart-1.rrze.uni-erlangen.de with
	ESMTP for linuxppc-embedded@ozlabs.org;
	Tue, 30 May 2006 09:45:47 +0200
Received: from max71.rrze.uni-erlangen.de ([131.188.3.181])
	by fau-vscan-1.rrze.uni-erlangen.de (fau-vscan-1.rrze.uni-erlangen.de
	[131.188.2.91]) (amavisd-new)
	with ESMTP id 26608-05-2 for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 May 2006 09:45:47 +0200 (MEST)
Received: from [131.188.51.43] ([131.188.51.43] [131.188.51.43]) by
	smtp-auth.uni-erlangen.de with ESMTP for
	linuxppc-embedded@ozlabs.org; Tue, 30 May 2006 09:45:46 +0200
Message-Id: <447BF82A.8000503@cs.fau.de>
Date: Tue, 30 May 2006 09:45:46 +0200
From: Josef Angermeier <Josef.Angermeier@informatik.uni-erlangen.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: undefined symbols of modules
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

when i try to compile my kernel extension as modul, i get some undefined 
references. But a look in System.map shows, that the relevant symbols 
are defined in the main kernel. Why then those undefined references ?

Any hint is appreciated!
bye

Josef

make ARCH=ppc -C linux modules
make[1]: Entering directory `/scratch-local/esm/linux'
  CHK     include/linux/version.h
  Building modules, stage 2.
  MODPOST
*** Warning: "cpm_load_patch" [drivers/usb/host/m82xx-hcd.ko] undefined!
*** Warning: "cpmp" [drivers/usb/host/m82xx-hcd.ko] undefined!
