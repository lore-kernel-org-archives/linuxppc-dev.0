Message-ID: <38C3F276.94C7566B@netx4.com>
Date: Mon, 06 Mar 2000 13:01:26 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Bjvrn Lundberg <bjorn.lundberg@inu.se>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: Performance 2.2.13 and USB work
References: <20000229054521.6C2385064E@brixi.research.canon.com.au> <38BCE4EF.85135592@inu.se> <kfyput8rv4y.fsf@kieraypc07.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:

> The fact that Dan's 2.2.13 uses write through cache is one thing that
> will affect performance. Grep for DC_SFWT in kernel/head.S and change
> the #if 0 to #if 1.


I did this because many people were using the standard
distribution libraries, which don't work with copyback
enabled.

For a real treat, download the linuxplanet-2.2.13 kernel
sources from MontaVista.  It includes some configuration
options that will be in the 2.3.xx sources once I get
them to compile :-).  For example, the copyback cache
and 860 Rev. B cpu6 silicon errata are configurable.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
