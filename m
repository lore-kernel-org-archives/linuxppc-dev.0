Return-Path: <reyems@telkomsa.net>
Received: from ctb-mesg5.saix.net (ctb-mesg5.saix.net [196.25.240.75])
	by ozlabs.org (Postfix) with ESMTP id E4C6067A58
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 01:24:02 +1000 (EST)
Message-ID: <003d01c65d7b$f88a6da0$1100a8c0@stefanlaptop>
From: "Stefan Meyer" <reyems@telkomsa.net>
To: "Kumar Gala" <galak@kernel.crashing.org>
References: <Pine.LNX.4.44.0604111013580.25404-100000@gate.crashing.org>
Subject: Re: Linux kernel for MPC834X platform
Date: Tue, 11 Apr 2006 17:24:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
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

Hi Kumar
Pardon my ignorance, but  I am not with you on the flat device tree and the 
new u-boot ??
Regards
Stefan


----- Original Message ----- 
From: "Kumar Gala" <galak@kernel.crashing.org>
To: "Stefan Meyer" <reyems@telkomsa.net>
Cc: <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, April 11, 2006 5:14 PM
Subject: Re: Linux kernel for MPC834X platform


> On Tue, 11 Apr 2006, Stefan Meyer wrote:
>
>> Hi Kumar
>> Thanks for the advice. I will rebuild for powerpc and report back.
>> B.t.w. what is the story behind the ppc and powerpc branches anyway ?
>
> The powerpc tree is a merge of the ppc32/64 trees into one arch.  It
> requires a flat device tree to boot.  You will need a new u-boot for this
> that produces a flat device tree.
>
> - kumar
>
> 
