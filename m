From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Robert E Brose II <bob@kunk.jriver.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Dual G3's in Umax S900?
Date: Thu, 2 May 2002 10:17:00 +0200
Message-Id: <20340830162052.29775@smtp.wanadoo.fr>
In-Reply-To: <20020502044441.3188.qmail@kunk.jriver.com>
References: <20020502044441.3188.qmail@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I have just dropped a PowerLogix g3/400 in place of the 233 mhz 604e
>in a Umax S900 and it's working great. What I'm wondering is
>if the SMP in the recent kernels would be able to handle a second
>g3/400? (The PL g3/400 board is so small that a second one would fit
>into the second CPU slot on the S900 which wasn't the case for
>normal 604e boards).

No. Doing SMP with G3s is a terrible nightmare as those CPUs don't
have the necessary coherency protocols.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
