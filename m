Return-Path: <Jogi95@web.de>
Received: from fmmailgate05.web.de (fmmailgate05.web.de [217.72.192.243])
	by ozlabs.org (Postfix) with ESMTP id C85C0DE29B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 04:32:30 +1100 (EST)
Date: Wed, 09 Jan 2008 18:29:40 +0100
Message-Id: <524275432@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux for ml310
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

Hi again

In which xparams* files should i look for the right definition=3F
In the xparameters.h from the BSP I can't find it, it looks like this:
-------------------------------------------------------------------
/*
 * include/asm-ppc/xparameters.h
 *
 * This file includes the correct xparameters.h for the CONFIG'ed board
 *
 * Author: MontaVista Software, Inc.
 *         source@mvista.com
 *
 * 2004 (c) MontaVista Software, Inc.  This file is licensed under the ter=
ms
 * of the GNU General Public License version 2.  This program is licensed
 * "as is" without any warranty of any kind, whether express or implied.
 */

#include <linux/config.h>

#if defined(CONFIG=5FXILINX=5FML300)
#include <platforms/4xx/xparameters/xparameters=5Fml300.h>
#endif
#if defined(CONFIG=5FXILINX=5FML40x)
#include <platforms/4xx/xparameters/xparameters=5Fml40x.h>
#endif
#if defined(CONFIG=5FMEMEC=5F2VPX)
#include <platforms/4xx/xparameters/xparameters=5F2vpx.h>
#endif

/*
 * A few reasonable defaults for the #defines which could be missing depen=
ding
 * on the IP version or variant (e.g. OPB vs PLB)
 */

#ifndef XPAR=5FEMAC=5F0=5FCAM=5FEXIST
#define XPAR=5FEMAC=5F0=5FCAM=5FEXIST 0
#endif
#ifndef XPAR=5FEMAC=5F0=5FJUMBO=5FEXIST
#define XPAR=5FEMAC=5F0=5FJUMBO=5FEXIST 0
#endif
#ifndef XPAR=5FEMAC=5F0=5FTX=5FDRE=5FTYPE
#define XPAR=5FEMAC=5F0=5FTX=5FDRE=5FTYPE 0
#endif
#ifndef XPAR=5FEMAC=5F0=5FRX=5FDRE=5FTYPE
#define XPAR=5FEMAC=5F0=5FRX=5FDRE=5FTYPE 0
#endif
#ifndef XPAR=5FEMAC=5F0=5FTX=5FINCLUDE=5FCSUM
#define XPAR=5FEMAC=5F0=5FTX=5FINCLUDE=5FCSUM 0
#endif
#ifndef XPAR=5FEMAC=5F0=5FRX=5FINCLUDE=5FCSUM
#define XPAR=5FEMAC=5F0=5FRX=5FINCLUDE=5FCSUM 0
#endif

#ifndef XPAR=5FEMAC=5F1=5FCAM=5FEXIST
#define XPAR=5FEMAC=5F1=5FCAM=5FEXIST 0
#endif
#ifndef XPAR=5FEMAC=5F1=5FJUMBO=5FEXIST
#define XPAR=5FEMAC=5F1=5FJUMBO=5FEXIST 0
#endif
#ifndef XPAR=5FEMAC=5F1=5FTX=5FDRE=5FTYPE
#define XPAR=5FEMAC=5F1=5FTX=5FDRE=5FTYPE 0
#endif
#ifndef XPAR=5FEMAC=5F1=5FRX=5FDRE=5FTYPE
#define XPAR=5FEMAC=5F1=5FRX=5FDRE=5FTYPE 0
#endif
#ifndef XPAR=5FEMAC=5F1=5FTX=5FINCLUDE=5FCSUM
#define XPAR=5FEMAC=5F1=5FTX=5FINCLUDE=5FCSUM 0
#endif
#ifndef XPAR=5FEMAC=5F1=5FRX=5FINCLUDE=5FCSUM
#define XPAR=5FEMAC=5F1=5FRX=5FINCLUDE=5FCSUM 0
#endif

#ifndef XPAR=5FGPIO=5F0=5FIS=5FDUAL
#define XPAR=5FGPIO=5F0=5FIS=5FDUAL 0
#endif
#ifndef XPAR=5FGPIO=5F1=5FIS=5FDUAL
#define XPAR=5FGPIO=5F1=5FIS=5FDUAL 0
#endif
#ifndef XPAR=5FGPIO=5F2=5FIS=5FDUAL
#define XPAR=5FGPIO=5F2=5FIS=5FDUAL 0
#endif
#ifndef XPAR=5FGPIO=5F3=5FIS=5FDUAL
#define XPAR=5FGPIO=5F3=5FIS=5FDUAL 0
#endif
#ifndef XPAR=5FGPIO=5F4=5FIS=5FDUAL
#define XPAR=5FGPIO=5F4=5FIS=5FDUAL 0
#endif
----------------------------------------------------

Did I something wrong in the edk Projekt, or are there other xparameters w=
here I must look=3F
Greetings & THX
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220
