Message-ID: <396DE80E.81BFABD1@embeddededge.com>
Date: Thu, 13 Jul 2000 12:02:22 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: CLLF860T FEC problem in linux-2.4.0-test4-pre6
References: <20000713085536.368DE289@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> Has anyone got any clues on this before I dive into it tomorrow?

A while back I posted a message stating I made lots of changes to this
driver based upon patches people have sent (including some of yours).
I also stated this is quite broken and I have not yet completed all
of the changes.  I am surprised it works at all.

I am now working on both the 8260 FCC (I have patches but will check
them in today), and the 8xx FEC as they are somewhat similar.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
