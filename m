To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: No bash prompt
References: <819E3E914E0AD11194DE00805F0D100B0138B833@fbi.infocom.dk> <kfyem88rat5.fsf@kieraypc01.p.y.ki.era.ericsson.se> <38F76951.CF7141E8@embeddededge.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 17 Apr 2000 10:09:42 +0200
In-Reply-To: Dan Malek's message of "Fri, 14 Apr 2000 14:54:09 -0400"
Message-ID: <kfyzoqtp2rd.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> My plan is just to force all 8xx ports to use the same IMMR address.
> This is part of the 8M page mapping of the kernel for performance
> enhancements.  I am going to collect as much I/O and IMMR into an
> 8M space as possible.  Someplace around 0xff000000 is going to be the
> "Linux" IMMR setting.

Sounds like a good idea.
In combination with explicitly setting IMMR to this address in
mbxboot/head.S it will save a lot of trouble for newcommers.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
