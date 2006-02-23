Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6DCFA679E2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 07:08:29 +1100 (EST)
In-Reply-To: <000001c6389e$980f0ff0$5201a8c0@GEG2400>
References: <000001c6389e$980f0ff0$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9A05AF34-3A14-4D64-9EDF-81D7C3C315FE@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Gianfar is slower  than fcc_enet on MPC8541 ???
Date: Thu, 23 Feb 2006 14:08:19 -0600
To: Laurent Lagrange <lagrange@fr.oleane.com>
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


On Feb 23, 2006, at 11:28, Laurent Lagrange wrote:

> Hi everybody,
>
> I tried the below Andy's idea. It works fine.
> It is my TCP clients which now slow the traffic.
>
> But I don't know why the default timeouts are so high.
> If the traffic is high, the timeout does not fire.
> If the traffic is low, the timeout seems too long (???).

The answer there is simple: stupidity!  :)  I just didn't carefully  
test the values for performance when I chose them.  I probably also  
did the math wrong, because I was more concerned about seeing if it  
worked at all.  It's also possible it got set that way to see a  
measurable difference to prove it was working, and then got left as  
the default.  Rest assured, there was not a deliberate reason.  We  
submitted a patch once this performance issue was discovered.
