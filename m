Subject: Re: PPC 405
To: Rakesh Jagota <j.rakesh@gdatech.co.in>
Cc: PPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OF7C040EFE.8193D1AD-ON87256D9E.004AC2E5-86256D9E.004B099E@us.ibm.com>
In-Reply-To: <3F6021CD.CC35DC55@gdatech.co.in>
From: Andrew H Pham <apham@us.ibm.com>
Date: Thu, 11 Sep 2003 08:37:16 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rakesh,

What kernel are you using?

Andrew Pham

[ Rakesh Jagota <j.rakesh@gdatech.co.in> writes: ]
>
> i am trying to integrate IR keyboard to a custom board.
> I am having serial console on the boad.
>
> when i am calling handle_scancode in keyboard.c
> this statement,
>
>  void handle_scancode(unsigned char scancode, int down)
>  {
>  -----
>  tty = ttytab? ttytab[fg_console]: NULL;
>  ;
>  }
>
> returns tty=NULL
>
>           __init kbd_init(void)
>  {
>   ------
>   ------
>   ttytab = console_driver.table;
>  }
>
> in this fuction also ttytab[fg_console] is still NULL
>
> Is serial console is enough to keyboard?
>
> i have frambuffer support on my board. (without HW
>       graphic accelerator)
>
> How to enable the frambufffer console on my board.
>       (i am attaching the config file below)
[ omitted ]

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
