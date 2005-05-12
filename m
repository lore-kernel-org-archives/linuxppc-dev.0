Return-Path: <sawitt@electra.rsc.raytheon.com>
Received: from tus-gate2.raytheon.com (tus-gate2.raytheon.com [199.46.245.231])
	by ozlabs.org (Postfix) with ESMTP id E94F567A03
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 02:15:44 +1000 (EST)
Date: Thu, 12 May 2005 08:48:27 -0700 (PDT)
From: Steve Witt <sawitt@electra.rsc.raytheon.com>
To: Atit_Shah <Atit_Shah@satyam.com>
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED10277B8@bsdmsg002.corp.satyam.ad>
Message-ID: <Pine.LNX.4.62.0505120840240.29988@zeus.ful.us.ray.com>
References: <D8595042F3765A4285B848A78A2C2ED10277B8@bsdmsg002.corp.satyam.ad>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Network Setup - HOW TO
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 12 May 2005, Atit_Shah wrote:

-- snip --

> The router should get an IP from my company server and assign it to eth1
> and then it should assign a IP to my standalone system connected to
> eth0. how do I do this?
>

I suspect you need to spend some time with the documentation of udhcp. You 
should be able to configure with network interface the server and client 
run on.

> DISCLAIMER: This email (including any attachments) is intended for the 
> sole use of the intended recipient/s and may contain material that is 
> CONFIDENTIAL AND PRIVATE COMPANY INFORMATION. Any review or reliance by 
> others or copying or distribution or forwarding of any or all of the 
> contents in this message is STRICTLY PROHIBITED. If you are not the 
> intended recipient, please contact the sender by email and delete all 
> copies; your cooperation in this regard is appreciated.

Now that I've read this disclaimer, its not clear that I am allowed (by 
your company) to answer your question. Its not clear to me whether I'm the 
intended recipient, nor whether this information you've sent is company 
private (to your company) or not.

These types of disclaimers are completely inappropriate for communications 
with a group of people discussing Open Source software and are, in fact, 
pointless. If you have company private information, then the 
responsibility to protect it is yours, not mine. I would ask that you 
remove this from subsequent emails to this list.
