Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 5167DDDEBA
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 08:09:55 +1100 (EST)
Message-ID: <45CCE31E.7020802@freescale.com>
Date: Fri, 09 Feb 2007 15:09:50 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCDEFB.5050504@ru.mvista.com> <45CCDFBC.1090104@freescale.com>
	<45CCE07F.9040107@ru.mvista.com> <45CCE107.5020709@freescale.com>
	<5C0E6DFA-71F4-49B2-B0B9-D6961B17A2C9@kernel.crashing.org>
In-Reply-To: <5C0E6DFA-71F4-49B2-B0B9-D6961B17A2C9@kernel.crashing.org>
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

Kumar Gala wrote:

>> Each family is maintained separately, so even if the resulting code is 
>> the same,
>> the patches need to be created individually.  I'll do them for 85xx 
>> and 86xx, too.
> 
> I assume you're talking about the u-boot side.

Yes.


-- 
Timur Tabi
Linux Kernel Developer @ Freescale
