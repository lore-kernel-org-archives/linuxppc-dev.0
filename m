Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 60F68DDE26
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 03:25:34 +1100 (EST)
Received: from vixen.sonytel.be (piraat.sonytel.be [43.221.60.197])
	by vervifontaine.sonycom.com (Postfix) with ESMTP id 239CB58ADF
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 18:25:19 +0200 (MEST)
Date: Tue, 31 Mar 2009 18:25:19 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: kexec: proc/device-tree/chosen/linux,kernel-end: No such file or
	directory
Message-ID: <alpine.LRH.2.00.0903311808310.32461@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With today's kernel, I can no longer kexec any kernel on PS3:

| /proc/device-tree/chosen/linux,kernel-end: No such file or directory
| Could not get memory layout

Today's bad version: 15f7176eb1cccec0a332541285ee752b935c1c85
Yesterday's good version: 0d34fb8e93ceba7b6dad0062dbb4a0813bacd75b

Before I start bisecting (tomorrow or the day thereafter), anyone with an idea?
Thanks!

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
