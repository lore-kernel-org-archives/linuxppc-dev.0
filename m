Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 1CFCF67AB3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 18:14:25 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j0Q7H0BB000172
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 09:17:00 +0200 (EET)
Message-ID: <41F74169.9050006@intracom.gr>
Date: Wed, 26 Jan 2005 09:06:17 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: robin.gilks@tait.co.nz
References: <41F70114.5040200@tait.co.nz>
In-Reply-To: <41F70114.5040200@tait.co.nz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: 8xx bus monitoring
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Robin Gilks wrote:
> Greetings
> 
> System is a MPC859 based controller.
> 
> I'm trying to determine whether a peripheral is not responding to memory 
> fetches by using the bus monitor feature on the Transfer Acknowledge 
> (TA) signal. This is set to the maximum count in the Bus Monitor Timeout 
> (BMT) in the System Protect Control Register (SYPCR). The monitoring is 
> enabled by setting the Bus Monitor Enable (BME) bit in SYPCR as well.
> 
> I understand that I can use the Transfer Error Status Register (TESR) to 
> read the fact that I have had a timeout by checking the Data Transfer 
> Monitor Timeout (DTMT) bit in this register.
> 
> The problem is, how do I know any error has occured so I know to look at 
>  the TESR. I can't see a way of generating an exception from this 
> condition.
> 
> Any help appreciated.
> 

You get a machine check exception.

It's pretty obvious then :)

Regards

Pantelis
