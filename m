Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 309AADE06E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Feb 2008 03:52:27 +1100 (EST)
Message-ID: <47A1FC89.7000307@freescale.com>
Date: Thu, 31 Jan 2008 10:51:21 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Steven Hein <ssh@sgi.com>
Subject: Re: Configuring Freecale ucc_geth without a PHY
References: <479F5D9B.8040403@sgi.com>	<20080129114310.3109caaa.kim.phillips@freescale.com>
	<47A1CF43.8070107@sgi.com>
In-Reply-To: <47A1CF43.8070107@sgi.com>
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

Steven Hein wrote:


> Is there a document anywhere that describes how to submit
> patches for the powerpc kernel?    Or do I just create the patch
> (I'm learning about git right now...) again the paulus/powerpc.git
> tree, and send it to this list?
> 

Correct.  Don't just lean toward git, actually use it.
And paulus/powerpc.git is the right basis.

Send it to the linuxppc-dev@ozlabs.org list, not here.

jdl
