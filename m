Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 44061DDF75
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:37:39 +1100 (EST)
Message-ID: <45D1F75C.80608@freescale.com>
Date: Tue, 13 Feb 2007 11:37:32 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCDEFB.5050504@ru.mvista.com> <45CCDFBC.1090104@freescale.com>
	<45CCE07F.9040107@ru.mvista.com> <45D1F46C.4050901@freescale.com>
	<45D1F659.6090106@ru.mvista.com>
In-Reply-To: <45D1F659.6090106@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sergei Shtylyov wrote:

>> Actually, the 2nd and third instances are conditionally compiled, so in 
> 
>    I think that's a bad excuse. You could have coded inline function at 
> least.

Fair enough.  I'll submit a new patch in a few minutes that makes the code an 
inline function.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
