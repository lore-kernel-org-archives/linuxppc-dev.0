Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id DD1C4DDEB9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 06:23:54 +1100 (EST)
Message-ID: <45D20F65.3040603@freescale.com>
Date: Tue, 13 Feb 2007 13:20:05 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCDEFB.5050504@ru.mvista.com> <45CCDFBC.1090104@freescale.com>
	<45CCE07F.9040107@ru.mvista.com> <45D1F46C.4050901@freescale.com>
	<5B1BBAE9-00FC-454B-8855-7D362DF59850@kernel.crashing.org>
	<45D1F92B.3000000@freescale.com>
	<774F090A-27E6-4271-ABFE-FBFA7855D5AD@kernel.crashing.org>
	<45D208CB.9000407@freescale.com>
	<FA1C9423-376B-41EC-AC41-992FAB4D88F0@kernel.crashing.org>
In-Reply-To: <FA1C9423-376B-41EC-AC41-992FAB4D88F0@kernel.crashing.org>
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

>> Looks like someone broke arch_initcall() or something.
> 
> Odd, what config is this? (powerpc.git or linux.git)
> 
> Just did a build of my powerpc.git tree w/o this issue.

Never mind.  I just did git-clone again and rebuilt, and now it works.  I guess 
there was stray keystroke somewhere that I didn't notice.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
