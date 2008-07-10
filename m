Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id E257BDDF70
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 08:10:28 +1000 (EST)
Message-ID: <48768A7B.1000506@windriver.com>
Date: Thu, 10 Jul 2008 18:17:31 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] mpc7448: add alias list to DTS, clean out old chosen node
References: <1215721295-17555-1-git-send-email-paul.gortmaker@windriver.com>	<48766E4D.5060607@freescale.com>
	<48767696.6090603@windriver.com> <48767636.3090906@freescale.com>
	<487679B1.3040900@freescale.com> <48767AD1.9050708@freescale.com>
	<4876823A.8010005@windriver.com> <487682E4.7060701@freescale.com>
In-Reply-To: <487682E4.7060701@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Paul Gortmaker wrote:
>> Well, for the mpc7448hpc2, I can say for sure that there are
>> chosen-duplicating versions of u-boot 1.3.1 in use -- since
>> there wasn't a prebuilt, validated image newer than 1.1.3(?)
>> available anywhere back some 6 months ago, I'd built 1.3.1
>> and made it available with our 2.6.21 kernel.
>
> OK, if that version's in widespread use it probably makes sense to 
> remove the chosen node.

Sounds good - thanks.

>
>> If all the other boards run cuboot without console output,
>
> They don't *all* run without output -- see the 8xx, 82xx, and 4xx boards.

Yep, saw those when grepping around.  My "all" was implicitly still
referring to the newer 83xx/85xx/(86xx) reference boards, and
whether it made sense to be adding chosen nodes to those so the
cuImage had console output too -- if folks thought that was a better
route, then I could see leaving the 7448 as-is, adding the nodes
to the other boards, and just dealing with educating folks on the
chosen-duplicating version issue as it comes up.

Paul.


>
> -Scott
>
