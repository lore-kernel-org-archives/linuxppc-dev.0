Message-ID: <411BECBA.1090602@eircom.net>
Date: Thu, 12 Aug 2004 23:18:34 +0100
From: Conor McLoughlin <cml3227@eircom.net>
MIME-Version: 1.0
To: "Cordes, Aaron M" <aaron.m.cordes@lmco.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.27-pre6-bk hangs on MPC8540 board
References: <EE7CAF713952AC4A970DD7CD8B4C12A042DCAC@emss09m06.us.lmco.com>
In-Reply-To: <EE7CAF713952AC4A970DD7CD8B4C12A042DCAC@emss09m06.us.lmco.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Disable the cache. The processor uses a burst access to fill a cache line.

Conor

Cordes, Aaron M wrote:
> Is there a way in Linux or the 8540 to prevent burst accesses, in order
> to test whether they are the problem?  I scanned the processor's
> reference manual, but I didn't see anything that would let me do this.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
