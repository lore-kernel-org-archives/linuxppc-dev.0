Message-ID: <3F61558F.EB3269C2@gdatech.co.in>
Date: Fri, 12 Sep 2003 10:41:43 +0530
From: Rakesh Jagota <j.rakesh@gdatech.co.in>
MIME-Version: 1.0
To: Andrew H Pham <apham@us.ibm.com>
Cc: PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PPC 405
References: <OF7C040EFE.8193D1AD-ON87256D9E.004AC2E5-86256D9E.004B099E@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi all,
We are using linux from montvista (linux-2.4.17_mvl21). We are
working on custom design board based on vulcan chip -stbx25xx
(IBM405 ppc). The board name is redwood6.

I am getting the following values

in fuction:  handle_scancode()
fg_console=0
ttytab[fg_console]=NULL;

what change i have  to do to get the keys on my serial console.
Thanks in advance
Rakesh

Andrew H Pham wrote:

> Rakesh,
>
> What kernel are you using?
>
> Andrew Pham
>
> [ Rakesh Jagota <j.rakesh@gdatech.co.in> writes: ]
> >
> > i am trying to integrate IR keyboard to a custom board.
> > I am having serial console on the boad.
> >
> > when i am calling handle_scancode in keyboard.c
> > this statement,
> >
> >  void handle_scancode(unsigned char scancode, int down)
> >  {
> >  -----
> >  tty = ttytab? ttytab[fg_console]: NULL;
> >  ;
> >  }
> >
> > returns tty=NULL
> >
> >           __init kbd_init(void)
> >  {
> >   ------
> >   ------
> >   ttytab = console_driver.table;
> >  }
> >
> > in this fuction also ttytab[fg_console] is still NULL
> >
> > Is serial console is enough to keyboard?
> >
> > i have frambuffer support on my board. (without HW
> >       graphic accelerator)
> >
> > How to enable the frambufffer console on my board.
> >       (i am attaching the config file below)
> [ omitted ]
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
