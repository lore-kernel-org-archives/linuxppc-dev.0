Message-ID: <3B69B4E7.8D14D272@mvista.com>
Date: Thu, 02 Aug 2001 15:15:35 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: roelensj@agcs.com
Cc: "Mike O'Brien" <mobrien@airfiber.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Hanging in Init
References: <000101c11ab4$0fc48f60$6865a8c0@airfiber.com> <3B69AD58.5C0A71BF@agcs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Yes the MontaVista glibc handles cache line size issues correctly.  (As
well as soft floating point so you do not need in kernel floating point
emulation.)

Jan Roelens wrote:
>
> You can't run a dynamically linked program unless you fix glibc regarding the cache line size.
> The 860 has a cache line size of 16 bytes instead of 32 bytes.
>
> Since you use a distribution, I suppose your glibc has been patched.
> ...
> Mike O'Brien wrote:
>
> > I have been trying to get a custom PPC860 board up using MonteVista's Hard
> > Hat
> > 2.0 distribution using a vxWorks bootrom.  I have made alot of progress in
> > ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
