Return-Path: <kumar.gala@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 48ACE2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Oct 2004 00:22:29 +1000 (EST)
In-Reply-To: <1099054203.10741.13.camel@lucy.pep-kaufbeuren.de>
References: <1099054203.10741.13.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EE71B8E2-29B5-11D9-952E-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 29 Oct 2004 09:22:15 -0500
To: "Stefan Nickl" <Stefan.Nickl@kontron.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: All-ones problem with FCC1 on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

[snip]
> We'll try to get hold of CDS eval board schematics to check more on the
>  hardware side, in the meantime, do you have an idea of which registers
>  to look at in particular?

Did not realize you were using a CDS, but physical ethernet port on the 
board do you believe the FCC is hooked up to?  While, some of the 
issues you are having in internal loopback seem to mean other problems, 
I believe the FCCs are only available for ethernet over some additional 
adapter add on cards.

- kumar
