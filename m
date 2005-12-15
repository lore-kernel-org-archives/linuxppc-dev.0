Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 542C768885
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Dec 2005 19:33:37 +1100 (EST)
Message-ID: <1134639546.43a139bab29ea@webmail.televes.com:443>
Date: Thu, 15 Dec 2005 10:39:06 +0100
From: Alex BASTOS <alebas@televes.com>
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
References: <1134555662.439ff20e6e812@webmail.televes.com:443>
	<43A0021E.7030406@ru.mvista.com>
	<1134569602.43a0288234662@webmail.televes.com:443>
	<43A028DB.5090906@ru.mvista.com>
	<386A8114-FA1C-44E2-A8F1-CF48F4AF495E@kernel.crashing.org>
In-Reply-To: <386A8114-FA1C-44E2-A8F1-CF48F4AF495E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Subject: Re: [SOLVED] Re: pq2_find_bridges hangs system
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar,

> >> Here is the problem. The cause for this weird behaviour is that I
> >> had PCI_ARBITER_EN_  disabled. So, a HW problem at the end.
> >> I had disabled it trying to reduce power compsumption due to the PCI,
> >> as I am not going to use it. It seems it is not possible that way.
> >> Any idea how to get this done?
>
> I'm guessing you dont have anything else doing arbitration on the bus.

You're right. I wasn't using the PCI at all.

>
> - kumar
>


Best regards,

Alex
