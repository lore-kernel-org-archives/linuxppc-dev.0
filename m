Message-ID: <3ADF490B.54CE4AFF@sgi.com>
Date: Thu, 19 Apr 2001 15:22:35 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860 RTC support
References: <3ADE0222.BF7F539C@sgi.com> <3ADE0501.321052F9@mvista.com> <3ADF1377.72242D3B@sgi.com> <3ADF3970.C015DB5D@mvista.com> <20010419124455.O13403@opus.bloom.county> <3ADF426A.5E9C0EBD@sgi.com> <20010419130646.P13403@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'd love to help here, but I can't find the source
you're talking about!!

I've looked in the mvista's 2.2.14 kernel, and in the LSP's
for rpxlite and mbx860, plus the real 2.4.3 kernel, and I
see no reference to PPC_RTC in drivers/macintosh or
arch/ppc/config.in!

Where should I be looking........?



Tom Rini wrote:
>
>
> Yes, I just noticed this myself when I went to try it on my rpx.
> What you'll need to do is:
> edit ./Makefile, and compile in drivers/macintosh/macintosh.o on
> CONFIG_PPC, not CONFIG_ALL_PPC.
> edit drivers/Makefile, and go into drivers/macintosh on CONFIG_PPC, not
> CONFIG_ALL_PPC.
> Finally, edit arch/ppc/config.in, and remove the test for !8xx around the
> PPC_RTC question.  Then it'll either work or die at boot.  I'm not sure
> yet :)  I should be able to test shortly tho.
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
