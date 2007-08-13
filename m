Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay009.isp.belgacom.be (mailrelay009.isp.belgacom.be
	[195.238.6.176]) by ozlabs.org (Postfix) with ESMTP id 7867EDDF1A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Aug 2007 19:30:15 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: basic and stupid question on wait_event and wake_up
Date: Mon, 13 Aug 2007 11:30:11 +0200
References: <BAY138-F307C7D793CEC734113D325B2DC0@phx.gbl>
In-Reply-To: <BAY138-F307C7D793CEC734113D325B2DC0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200708131130.11871.laurentp@cse-semaphore.com>
Cc: domen.puncer@telargo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Monday 13 August 2007 11:22, Ming Liu wrote:
> Dear Momen,
> OK. I see now. So you mean condition is only to judge whether a sleeping
> process could be waken up or not when wake_up() is executed in other
> processes or interrupt handlers. What really wakes the process up is still
> the function of wake_up, right? We just execute wake_up() and then check if
> condition is true. If yes, the process will leave its sleeping and wake up;
> if not, it keep sleeping. Am I right?

Actually, the process will wake up every time you call wake_up(). It will then 
evaluate the condition. If the condition is true, the process will return 
from wait_event. If the condition is false, it will go back to sleep.

Best regards,

Laurent Pinchart
