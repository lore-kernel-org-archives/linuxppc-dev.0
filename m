Return-Path: <Regis.Odeye@kontron.com>
Received: from mail.kontron.fr (mail.kontron.fr [217.109.32.201])
	by ozlabs.org (Postfix) with ESMTP id 96956B7B74
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Nov 2009 03:54:13 +1100 (EST)
Message-ID: <4B02D259.6030905@kontron.com>
Date: Tue, 17 Nov 2009 17:42:01 +0100
From: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 8641D, gianfar driver and BAD Interruptions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,
On a board based on 8641D, we have BAD interruptions (cat 
/proc/interrupts) which means spurious interruptions seen by the MPIC. 
The number of this BAD ITs are increasing during the life time of the 
system and depending on the ethernet activity.
So this seems to come from the gianfar and we experimented that:
- when we are binding the three interruptions enet_tx, enet_rx and 
enet_err of each interfaces on the same processor, the BAD interruptions 
do not increase any more.
- when we are compiling the driver without the NAPI mode, there is no 
more BAD interruptions at all.
We are playing with a 2.6.25 + some patches Linux kernel.
I did not analyze the errata list of 8641D with this perspective but is 
there anybody who get some inputs about the phenomenon ?
Regards.

-- 
Régis ODEYE

Kontron Modular Computers SA
150, rue M. Berthelot / ZI Toulon Est / BP 244 / Fr 83078 TOULON Cedex 9
Phone: (33) 4 98 16 34 86           Fax: (33) 4 98 16 34 01
E-mail: regis.odeye@kontron.com  Web : www.kontron.com
