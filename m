Return-Path: <jean-marie.teuler@lcp.u-psud.fr>
Received: from smtp2.u-psud.fr (smtp2.u-psud.fr [129.175.33.42])
	by ozlabs.org (Postfix) with ESMTP id 5C71067B1D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 20:41:20 +1000 (EST)
Subject: Re: Impossible to open the root console with 2.6.15
From: Jean-Marie Teuler <jean-marie.teuler@lcp.u-psud.fr>
To: Mark Chambers <markc@mail.com>
In-Reply-To: <005801c66ee1$ba2b1380$6601a8c0@CHUCK2>
References: <1146663369.2448.25.camel@khnoum.lcp.u-psud.fr>
	<005801c66ee1$ba2b1380$6601a8c0@CHUCK2>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 04 May 2006 12:42:36 +0200
Message-Id: <1146739357.6866.12.camel@khnoum.lcp.u-psud.fr>
Mime-Version: 1.0
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

Dear Mark,

> Are you passing a 'console=' option to the kernel, like 'console=ttyCPM0' or 
> 'console=ttyCPM1'.

No. I was not passing any option (besides the standard NFSROOT options
(root=/dev/nfs rw nfsroot= ip=).

Actually, the trick suggested by Jean-François Simon (disabling the
virtual terminals option in the kernel configuration) solved the problem
(please see my previous post).

Thanks for your interest anyway.

Jean-Marie
