Return-Path: <torvalds@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A245C67B63
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 05:59:19 +1000 (EST)
Date: Fri, 15 Sep 2006 12:59:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <Pine.LNX.4.64.0609141633310.4388@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0609151258170.4388@g5.osdl.org>
References: <17671.64971.450232.870486@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609141208510.4388@g5.osdl.org>
	<17673.56806.552948.748504@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609141633310.4388@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 14 Sep 2006, Linus Torvalds wrote:
> 
> Ok, maybe the debian brokenness exists in FC5 too, and a "yum upgrade" 
> broke it for me rather than any kernel work.

That does seem to be the case. The printer is back up, apparently after a 
"cups-lpr" update. Sorry about the noise, although the strace thing still 
bothers me. Not enough to pursue it any more, though ;)

		Linus
