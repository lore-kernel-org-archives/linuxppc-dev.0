Date: Fri, 19 Dec 2003 10:55:03 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: aic7xxx revisited...
Message-ID: <20031219165503.GA5255@uchicago.edu>
References: <20031219092217.GA20303@uchicago.edu> <1071830540.753.3684.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1071830540.753.3684.camel@gaston>
From: alecwood@cs.uchicago.edu (Alec Wood)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thus spake Benjamin Herrenschmidt:

> Try to find all occurences of
>
> #define MMAPIO
>
> in drivers/aic7xxx/* and replace them with
>
> #undef MMAPIO
>
> Then let me know.

Yeah, it boots fine after doing that!

<snip>
> While I agree that an early crash is better than silent malfunction, I
> still think something weird is going on here, maybe we are misconfiguring
> something in the CPU (not broadcasting eieo to the bus) or the apple
> nortbridge isn't doing things right... Unfortunately, I haven't had
> direct access to HW showing the problem and thus couldn't investigate
> more.

Well, I don't have any kernel development experience per se, but I'd
like to make myself useful... please advise!

Cheers,
Alec

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
