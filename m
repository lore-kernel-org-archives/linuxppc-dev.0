Message-ID: <3FC4C428.3040707@jonmasters.org>
Date: Wed, 26 Nov 2003 15:18:00 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc405 floating point emulation
References: <20031126144846.791C1C5F5F@atlas.denx.de>
In-Reply-To: <20031126144846.791C1C5F5F@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> Library support (i. e. using "-msoftfloat") works fine.

Yes good. I had thought it would be fine to use that.

> Kernel emulation is available, but makes little sense to use as it is
> awfully slow.

The problem I have with this kernel is that floating point emulated
instructions which perform stores seem to be falling over. There is
a bug in the fault handling code for stock 2.4.21 that I am using it
would seem but am looking at whether it is worth fixing it.

By all accounts I might as well just use the floating point emulation in
libc but am still interested in enlightened feedback.

Cheers,

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
