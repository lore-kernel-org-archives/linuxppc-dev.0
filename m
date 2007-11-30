Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id EC692DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 09:27:28 +1100 (EST)
To: Stuart Hodgson <stuart@quadrics.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Semaphores in eldk4.1
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Nov 2007 16:33:30 GMT."
	<47503B5A.6090604@quadrics.com>
Date: Fri, 30 Nov 2007 23:27:26 +0100
Sender: wd@denx.de
Message-Id: <20071130222726.1E0DB247C1@gemini.denx.de>
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

In message <47503B5A.6090604@quadrics.com> you wrote:
> 
> I have been suing the eldk4.1 tool chain for a few months now and have 

Please post ELDK related questions on the ELDK mailing list instead,
see http://lists.denx.de/mailman/listinfo/eldk

> The problem I have come up against is related to some of the semaphore 
> functions in semaphore.h, namely sem_wait, sem_post. This was originally 
> noticed in a third party driver I am porting from one board to another 
--------------------------^^^^^^^^
> but a small test program has shown the same results.

What exactly are you talking about? Device driver (i. e. kernel)
code, or application (i. e. user space) code ?

> Calls to these functions on the ppc_82xx platform return -1 with an 
> error code of 38, in this case meaning  ENOSYS (not implemented). On the 

Did you enable the CONFIG_SYSVIPC option in your Linux kernel
configuration?

> ppc_85xx the same program executes fine, thus I conclude that it is 
> specific to the libc-2.3.5 for ppc_82xx. Has anyone else come across 
> this problem, I did find one thread but there was no conclusion listed.

There is absolutley no difference between ppc_85xx and ppc_82xx as
far as library sources or configuration are concerned. The problem is
most probably in your Linux kernel, I guess.

> I also can not find anything stating that these functions are not 
> implemented for the 82xx arch compared with others for the eldk4.1

Provide a test program that fails for yuou, and we can provide much
better comments.

But please post followups on the ELDK mailing list.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Old programmers never die, they just become managers.
