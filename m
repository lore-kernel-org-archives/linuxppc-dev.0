In-Reply-To: <85256862.00703603.00@D51MTA03.pok.ibm.com>
Date: Mon, 10 Jan 2000 23:41:27 +0100
To: jlquinn@us.ibm.com, linuxppc-dev@lists.linuxppc.org
From: BenH <bh40@calva.net>
Subject: Re: 2.3.39-pre2 boots
Message-Id: <20000110234127.024647@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Jan 10, 2000,  <jlquinn@us.ibm.com> wrote:

>Did stock 2.3.38 build for you?  I still can't compile it.  There is still
>an error due to irq_offset in arch/ppc/kernel/open_pic.c.  I also get an
>error in (I think) pmac_nvram.c.  Sorry, didn't write it down.
>
>I'm trying to configure the kernel as Powermac only, rather than
>powermac/prep/chrp.  Might this be my problem?

Try 2.3.39pre2, there was several PPC fixes merged in this one.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
