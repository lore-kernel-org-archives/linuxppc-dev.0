Return-Path: <Regis.Odeye@kontron.com>
Received: from mail.kontron-modular.com (mail.kontron-modular.com
	[213.179.130.140]) by ozlabs.org (Postfix) with ESMTP id 04C92DDF0F
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Feb 2009 03:48:40 +1100 (EST)
Message-ID: <49A2D364.8090305@kontron.com>
Date: Mon, 23 Feb 2009 17:48:36 +0100
From: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 86xx: e600 and cputable.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On our board based on 8641D, cat /proc/cpuinfo gives:
-bash-3.2# cat /proc/cpuinfo
processor       : 0
cpu             : 7448, altivec supported
clock           : 1000.000000MHz
revision        : 0.2 (pvr 8004 0202)
bogomips        : 199.68

processor       : 1
cpu             : 7448, altivec supported
clock           : 1000.000000MHz
revision        : 0.2 (pvr 8004 0202)
bogomips        : 199.68

total bogomips  : 399.36
timebase        : 100000000
platform        : VM6250
Vendor          : Kontron Modular Computers
Machine         : VM6250
SVR             : 0x80900121
Memory          : 1024 MB

Is there a plan to deal with e600 core as it is done for e500 in 
cputable.c to be able to discriminate "classic" ppc against freescale 
cores ?
Already a patch ?

Regards.

-- 
Régis ODEYE

Kontron Modular Computers SA
150, rue M. Berthelot / ZI Toulon Est / BP 244 / Fr 83078 TOULON Cedex 9
Phone: (33) 4 98 16 34 86           Fax: (33) 4 98 16 34 01
E-mail: regis.odeye@kontron.com  Web : www.kontron.com
