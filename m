Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 03640DDE48
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 08:00:59 +1100 (EST)
Message-ID: <45CCE107.5020709@freescale.com>
Date: Fri, 09 Feb 2007 15:00:55 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCDEFB.5050504@ru.mvista.com> <45CCDFBC.1090104@freescale.com>
	<45CCE07F.9040107@ru.mvista.com>
In-Reply-To: <45CCE07F.9040107@ru.mvista.com>
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

>    I'm mainly concerned about 85xx. I guess the needed change should be 
> very alike...

Each family is maintained separately, so even if the resulting code is the same, 
the patches need to be created individually.  I'll do them for 85xx and 86xx, too.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
