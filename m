Message-ID: <20020502153458.10004.qmail@kunk.jriver.com>
Subject: Re: Dual G3's in Umax S900?
In-Reply-To: <20020502131439.13109@smtp.adsl.oleane.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 2 May 2002 10:34:58 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
Cc: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>,
	linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


User Benjamin Herrenschmidt says:
> >> No. Doing SMP with G3s is a terrible nightmare as those CPUs don't
> >> have the necessary coherency protocols.
> >>
> >Is MEI not enough for Linux? Instruction cache coherency problems? Or is it
> >because of the rudimentary implementation of tlbie/tlbia? Just curious.
>
> I don't have all in mind, from memory, the lack of bus broadcast for tlbie
> is one, the lack of bus coherency for cache inval is another, but I am not
> sure.
>
> I think in the past, we used to have BeBox (dual 603) working, which I suppose
> is pretty similar, but still hell. No way I support that for pmac kernels.
>
> Ben.

I assume then that the 604e has what's needed because IBM has RS6ks with
multiples of these??

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
