Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1B0652BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Sep 2004 01:27:21 +1000 (EST)
To: "Robert P. J. Day" <rpjday@mindspring.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 25 Sep 2004 11:10:45 EDT."
	<Pine.LNX.4.60.0409251109150.4235@dell.enoriver.com>
Date: Sat, 25 Sep 2004 17:27:12 +0200
Sender: wd@denx.de
Message-Id: <20040925152717.F29D4C108D@atlas.denx.de>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] to support choice of 8xx microcode patch 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <Pine.LNX.4.60.0409251109150.4235@dell.enoriver.com> you wrote:
>
> > Where do you select which CPU type gets  used,  and  adjust  for  the
> > corresponfding version of the uCode patch?
> 
> are you referring to the distinction you make in the DENX 2.4 tree, 
> where you distinguish between 850 and non-850 architectures?  since 

This is one part of what needs to be done. Also,  the  MPC866  family
handles relocation differently.

> that appears to be done manually, i see no reason why the same 
> couldn't be done in the patch i submitted.  it would be a trivial 
> change to get the same effect.

You are right. But since you wrote  "this  is  a  *full*  ...  patch"
(emphasis  by  yourself)  I  somehow  expected  that you covered this
problem, too.

Sorry if this was a misunderstanding.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"The more data I punch in this card,  the lighter it becomes, and the
lower the mailing cost."
                     - Stan Kelly-Bootle, "The Devil's DP Dictionary"
