Message-ID: <3BB265B6.E6153B75@mvista.com>
Date: Wed, 26 Sep 2001 16:33:10 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: "Prasad, Siva" <Siva.Prasad@smartm.com>
Cc: "'Tom Rini'" <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mtmsr...
References: <35C119252057D511BB9F0003476BF8A208E5C4@freexc01.smartm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Prasad, Siva" wrote:

> 'PowerBoot' is the firmware I am using.
>
> I preferred to use 2.2.14 because, it has PowerCore option, where I can use
> 750  with minimal changes.

Siva, my guess is that it is one of two things:
a) The value you are putting into the msr is bad and making it hang (like
turning on the mmu)
b) Its a stale cache problem and the instructions you *think* you are
executing aren't really what the processor is executing.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
