Date: Mon, 1 Apr 02 12:09:12 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0204012009.AA28614@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> Anyway, I don't care.  I'm done with this conversation.

Responding for the benefit of others on the list who aren't...

> I guess you didn't get it.  What I meant was to change find_bootinfo to use
> r3+KERNELBASE.

Then why do you need find_bootinfo at all? Just pass r3+KERNELBASE as the
argument to parse_bootinfo().

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
