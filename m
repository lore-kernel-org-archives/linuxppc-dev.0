Message-Id: <4.2.2.20040519125913.05088e50@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 13:01:23 -0700
To: Wolfgang Denk <wd@denx.de>
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Ebony Board, PPC440GP and NFS panics 
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040519195405.98971C109F@atlas.denx.de>
References: <Your message of "Wed, 19 May 2004 10:16:29 PDT." <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Correction,

The platform stuff is down in arch/ppc/platforms/4xx for the PPC4xx
stuff.  There is an ebony.h [ and several others ],
but they don't include the ppcboot.h...which would explain why it isn't
getting any information passed from u-boot.



At 09:54 PM 5/19/04 +0200, Wolfgang Denk wrote:

>.
>
>The question is: does your "arch/ppc/platforms/ebony.h" include
><asm/ppcboot.h> or not, i. e. does it use the U-Boot definitions at
>all?
>
>Best regards,
>
>Wolfgang Denk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
