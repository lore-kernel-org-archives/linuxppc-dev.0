Return-Path: <siju@india.tejasnetworks.com>
Received: from anche.india.tejasnetworks.com (india.tejasnetworks.com
	[164.164.94.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3355C67B79
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 21:07:12 +1100 (EST)
Subject: Re: [BULK]  Re: "transmit timed out" on FCC in MPC8260 as well as
	MPC8247
From: Siju Viswanath K E <siju@india.tejasnetworks.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060324075148.4C106353BFB@atlas.denx.de>
References: <20060324075148.4C106353BFB@atlas.denx.de>
Content-Type: text/plain
Message-Id: <1143193658.22246.20.camel@Blaze>
Mime-Version: 1.0
Date: 24 Mar 2006 15:17:39 +0530
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

Hi Denk,
	Thanks for the suggestion. I had a look at the source repository
at projects/linuxppc_2_4_devel.git site. Outdated code doesnt seem to be
the issue. My repository is patched upto 
"Patch by Wojciech Kromer, 06 Jan 2004" and later changes are only
adding extra board support. 

regards,
Siju Viswanath

On Fri, 2006-03-24 at 13:21, Wolfgang Denk wrote:
> In message <1143177651.22246.3.camel@Blaze> you wrote:
> >
> > 	I am using denk's linuxppc-2.4.20 . I am getting this problem of
> 
> Why don't you try using a more current version of the code? 2.4.20 is
> *very* old, and *lots* of bugs and problems have been fixed since.
> 
> It really does not make sense to spend effort on such old code.
> 
> Best regards,
> 
> Wolfgang Denk
