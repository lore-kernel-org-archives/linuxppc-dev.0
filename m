Message-ID: <3DF84AD5.9090500@intracom.gr>
Date: Thu, 12 Dec 2002 10:37:41 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>, joakim.tjernlund@lumentis.se,
	acurtis@directvinternet.com, Paul Mackerras <paulus@au1.ibm.com>,
	Matt Porter <porter@cox.net>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <20021212081841.390C7C613A@atlas.denx.de>
In-Reply-To: <20021212081841.390C7C613A@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

>In message <3DF8420A.4040409@intracom.gr> you wrote:
>
>
>>They only reason that I considered the consistent() routines was
>>that the 8xx routines are unsuitable for use in modules.
>>
>>
>
>This  is  trivial  to  fix  -  just  add  the  missing  EXPORT_SYMBOL
>statements  to  arch/ppc/kernel/ppc_ksyms.c  ;  but be aware that the
>current implementation will leak CPM resources upon module  unload  -
>which  is probably the main reason that these symbols are not expoted
>for use in modules.
>
Yes I know, that is one the main deficiencies I'm talking about...

>
>>I will prepare a patch that deals with the inefficiencies
>>of the 8xx routines.
>>
>>
>
>Don't re-invent the wheel. There is an implementation  of  this  code
>available  in  our  kernel  source tree (linux-2.4 module in our CVS)
>which for example provides both m8xx_cpm_dpalloc / m8xx_cpm_dpfree
>
>I sent the patches to Tom Rini. Several times. I don't know why  they
>never  made  it into the official kernel source tree. [This is why we
>have to maintain our own source tree.]
>
>
>Best regards,
>
>Wolfgang Denk
>
Could you please sent me these patches, since I'm behind a firewall?

But still there is the matter of the m8xx_cpm_hostalloc routines.

BTW Wolfgang have you seen my patch for the QMC? Any comments?
Please note that I had a few requests for the QMC patch directly
by people off the list, so it's not like no-one is using it...

Regards

--
Pantelis Antoniou
INTRACOM S.A. Greece


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
