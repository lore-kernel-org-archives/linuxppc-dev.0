Return-Path: <sonic_amiga@rambler.ru>
Received: from gw2.leta.ru (gw2.leta.ru [88.210.57.116])
	by ozlabs.org (Postfix) with ESMTP id E5EC2DDEC5
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 17:38:30 +1100 (EST)
Date: Wed, 7 Feb 2007 09:38:00 +0300
From: Pavel Fedin <sonic_amiga@rambler.ru>
Message-ID: <1241886047.20070207093800@rambler.ru>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: patches in powerpc.git
In-Reply-To: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
References: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: sonic_amiga@rambler.ru
Cc: linuxppc-dev@ozlabs.org
Reply-To: Pavel Fedin <sonic_amiga@rambler.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Paul,

Wednesday, February 7, 2007, 7:03:13 AM, you wrote:

> If anyone has patches not listed here that they want in 2.6.21, please
> let me or the relevant sub-arch maintainer know.  I have put in all
> the patches I know about that don't seem to be still under discussion.

  You've forgotten this one:

http://patchwork.ozlabs.org/linuxppc/patch?id=9215

 It's well tested working code which has already been included for
old "ppc" target since 2.6.11. However it was lost again during
ppc64+ppc->powerpc transition (i see that "powerpc" target is based on
old "ppc64", not "ppc").

-- 
Best regards,
 Pavel                            mailto:sonic_amiga@rambler.ru
