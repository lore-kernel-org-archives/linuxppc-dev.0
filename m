Return-Path: <ALEBAS@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 5CBE367BCE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 19:39:12 +1000 (EST)
Message-ID: <1144842264.443ce818d6822@webmail.televes.com:443>
Date: Wed, 12 Apr 2006 13:44:24 +0200
From: Bastos Fernandez Alexandre <ALEBAS@televes.com>
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: Watchdog on MPC82xx
References: <1144835330.443ccd021b40a@webmail.televes.com:443>
In-Reply-To: <1144835330.443ccd021b40a@webmail.televes.com:443>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> So, can anyone give me some guidelines for this job? I have seen from
> freescale docs that MPC83xx watchdog may be the same than MPC82xx one.
> So, could I use the same approach than used on MPC83xx boards?
>
> http://patchwork.ozlabs.org/linuxppc//patch?id=4118
>

Though Freescales doc for MPC83xx says:

• Functional and programming compatibility with MPC8260 watchdog timer

further reading shows that there is a "little" difference. MPC83xx can
come out of reset with WDT disabled, while MPC82xx can't. So the approach
for MPC83xx is not possible on those other systems.

So, any other idea? Is the WDT on MPC8248 usable at all?

Thanks,

Alex
