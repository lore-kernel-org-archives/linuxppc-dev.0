Return-Path: <hollis@penguinppc.org>
Received: from smtpauth07.mail.atl.earthlink.net
	(smtpauth07.mail.atl.earthlink.net [209.86.89.67])
	by ozlabs.org (Postfix) with ESMTP id 261A068647
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 13:28:55 +1100 (EST)
In-Reply-To: <20051031002926.M71008@quicknet.nl>
References: <1130645036.29054.229.camel@gaston>
	<20051031002926.M71008@quicknet.nl>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Message-Id: <2828913a7186e850887d415a8311dc44@penguinppc.org>
From: Hollis Blanchard <hollis@penguinppc.org>
Date: Sun, 30 Oct 2005 20:28:49 -0600
To: "Ingmar" <i2a@gmx.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: exception vectors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Oct 30, 2005, at 6:35 PM, Ingmar wrote:
>
> I am trying to overwrite the exception vector space of an ibook G4 :).

Why?

> I have set up (for every exception) a small piece of code, that's a=20
> prefix of a
> handler to be called. My problem is, that writing the =93small=94 =
chunks=20
> of code to
> the exception vector space gives no problem(so it seams) but writing=20=

> all the
> pieces of code as one chunk gives a exception [dsi, dsisr 0x42000000],=20=

> this
> indicates a store problem.

Code please. You're just calling memcpy?

> I have tried different modes of copying, mmu on/off, also chanced the=20=

> WING bit,
> switched the exception prefix on.

You could not have gotten a DSI if you disabled the MMU...

> I don't believe putting the exception vectors to there =93place=94 one =
by=20
> one is the
> right way, in the Linux kernel the kernel get relocated and the code=20=

> comes into
> place. I have taken this as an example, unfortunately to to result =
:(..

So you are not trying to overwrite Linux's functioning exception=20
handlers, but rather trying to write your own OS?

>  - Am I overlooking something?
>  - Is the a =93standard way=94 to overwrite the exception vector space =
of=20
> a powerpc?

Do you think this is a common task? :)

-Hollis
