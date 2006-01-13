Return-Path: <tsawyer+linuxppc@sandburst.com>
Received: from sandmail.sandburst.com (sandmail.sandburst.com [216.57.132.42])
	by ozlabs.org (Postfix) with ESMTP id 575AA68916
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 00:58:39 +1100 (EST)
Message-ID: <43C7AA6D.5060206@sandburst.com>
Date: Fri, 13 Jan 2006 08:26:05 -0500
From: "Travis B. Sawyer" <tsawyer+linuxppc@sandburst.com>
MIME-Version: 1.0
To: David Hawkins <dwh@ovro.caltech.edu>
Subject: Re: Suggestions for a PPC440 board?
References: <43C7051D.8000001@ovro.caltech.edu>
In-Reply-To: <43C7051D.8000001@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

David Hawkins wrote:

>Hi all,
>
>I'm evaluating the Yosemite 440EP board at the moment,
>with the intention of using it on custom compactPCI
>boards. I've got a few questions to ask the group, but
>I'll leave those for another email.
>  
>
<Snip>

>So, I might not follow this
>route. Alternatively, I could use a PMC, or PrPMC
>board, and develop the drivers that way, eg.
>
>Extreme Engineering    Xpedite1000/1  440GX
>Artisyn Technologies   PmPPC          440GP
>
>So - anyone have a favorite?
>  
>
David:

I've already done the Das u-boot port for the Xpedite1k, and its released.

If that makes it any easier for you to decided.

Granted the port was done for monarch mode, not non-monarch, but it 
should be simple
enough to change that.

-travis
