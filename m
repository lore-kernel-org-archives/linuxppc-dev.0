Date: Wed, 11 Jul 2001 00:34:02 -0700
From: Ira Weiny <iweiny@acm.org>
Subject: Re: IBM Microdrive PCCard on TiBook (ide-cs module)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>, blythe@routefree.com
Message-id: <3B4C016A.CA1BEFB0@acm.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <3B460601.6A3AA7D9@acm.org> <20010707103519.972@smtp.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> I think the problem has more to do with disabling the interrupt at
> the proper place in the IDE layer, I can try to find that discussion
> on linux-kernel to see if they came up with a solution, the problem
> seem to happen on x86 as well.
>

Thanks to Ben and David Blythe for your responses.  Indeed I think you
are correct.  Unfortunatly I found a patch posted by Gunther Mayer on
the Linux-kernel mailing list which does not seem to fix things either.
His patch looks like it does what David described; disabling interrupts
and then reenabling them in init_irq...  But it does not work...  ;-(

At this point the only thing I can think of is that the device is not
responding to the interrupt disable?  Or I have missed something with
the patch.  David, you would not happen to be able to send me a patch or
your entire ide tree?

Oh well I just thought I would thank you guys for leading me the correct
way.

Thanks again,
Ira Weiny
iweiny@acm.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
