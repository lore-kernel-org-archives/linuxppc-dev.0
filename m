Subject: Re: Altivec Vector code bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Whitney <jwhitney-linuxppc@sands-edge.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <BE309A52-8807-11D8-B1DF-000A95A07384@sands-edge.com>
References: <BE309A52-8807-11D8-B1DF-000A95A07384@sands-edge.com>
Content-Type: text/plain
Message-Id: <1081319452.1382.44.camel@gaston>
Mime-Version: 1.0
Date: Wed, 07 Apr 2004 16:30:53 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-04-07 at 06:19, John Whitney wrote:
> The attached patch corrects the following problem with the Altivec
> vector:
>
> When running Linux 2.6.5-rc2 (Altivec NOT configured in) on a 7410-base
> platform, and running a program that attempts to use a vector register,
> the kernel will lock up.  This is due to vectoring to 0xf20, which is
> in the middle of the exception prolog as the exception handler is now
> written.

Thanks, forwarded upstream.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
