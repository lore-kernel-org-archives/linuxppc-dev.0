Message-ID: <390F4501.889D2C82@mandrakesoft.com>
Date: Tue, 02 May 2000 17:13:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
MIME-Version: 1.0
To: tom_gall@vnet.ibm.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Display Adapters / i386 interpreter
References: <390F42CB.11AAF8D@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


tom_gall@vnet.ibm.com wrote:
>   Is there an IA32 interpreter of sorts that can run the small amount of
> BIOS to bring up the card?

That's the solution that PPC (AFAIK), Alpha AXP, and XFree86 all use.
(though XFree uses vm86 mode if present/possible, and also runs the BIOS
for non-primary adapters)

	Jeff


--
Jeff Garzik              | Nothing cures insomnia like the
Building 1024            | realization that it's time to get up.
MandrakeSoft, Inc.       |        -- random fortune

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
