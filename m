Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1A4A7DDE08
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2007 00:44:06 +1100 (EST)
Message-ID: <45DD9E1B.7060604@ru.mvista.com>
Date: Thu, 22 Feb 2007 16:43:55 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: ebony.zhu@freescale.com
Subject: Re: [patch][5/5] powerpc V2: Add the general support for Embedded
	Floating-Point instructions
References: <ZCH01EXM202TRqf69aZ00001061@zch01exm20.fsl.freescale.net>
	<45DD911D.1090101@ru.mvista.com>
In-Reply-To: <45DD911D.1090101@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

>> Add the general support for Embedded Floating-Point instructions
>> to fully comply with IEEE-754.

>>  arch/powerpc/sysdev/sigfpe_handler.c |  361
>> ++++++++++++++++++++++++++++++++++

>    I'm sorry, but is sysdev/ really fitting place for this file? 
> Shouldn't it be under kernel/ or math-emu/ instead?

    Also, the name doesn't look fittingto me, since we're not handling 
*SIGFPE* here (which is for userland), we're handling SPE exceptions.

WBR, Sergei
