Message-ID: <39F8762D.B7569B16@mvista.com>
Date: Thu, 26 Oct 2000 14:21:33 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Julia Elbert <jelbert@enerdyne.com>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cpm interrupts
References: <67505026E29DD311A9AA00508B7315F350A579@EXCHANGE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Julia Elbert wrote:

> Is there any way to see what cpm interrupts are actually registered after
> the drivers load?

No, I probably should do something that works with /proc......

> This happens after my kernel boots. I call ifconfig to bring up hdlcppp2 and
> I get this message.
>
>         CPM interrupt c00af4dc replacing c00af4dc

You are installing the interrupt handler again.  The c00af4dc is the
address of the interrupt handler.......


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
