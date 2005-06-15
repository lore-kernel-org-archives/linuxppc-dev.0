Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.182.165]) by ozlabs.org (Postfix) with ESMTP id AEA8F67B61
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 01:12:23 +1000 (EST)
Message-ID: <00c601c571bc$be6c8320$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
To: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>,
	<linuxppc-embedded@ozlabs.org>
References: <8E342283C2100540AAC5D1030970547766F7A1@rcexc.racoms.loc>
Date: Wed, 15 Jun 2005 11:13:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: 2.4.26 and MPC885 context switching time
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>Hi all,
>
>i'm evaluating IPC on the MPC885ADS and discovered
>that the context switching times seem to be quite 
>disappointing (up to 1ms). As we need to do a lot 
>of IPC later on, i'm interested bringing the time 
>down.
>
>Therefore i wonder, if there are any known problems 
>with the MMU on 8xx and 2.4.2x which might explain 
>that? 

Maybe it would help if you gave more detail about how
you are measuring these times in your system.

I'm interested to know the answer to this myself!

Mark Chambers
