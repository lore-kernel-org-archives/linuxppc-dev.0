Message-ID: <3CA8A0E6.BC40907F@mvista.com>
Date: Mon, 01 Apr 2002 13:03:18 -0500
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] ev64260 bi_rec patch
References: <0204011931.AA28474@ivan.Harhan.ORG>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Sokolov wrote:

> > Is there a reason we shouldn't just fix find_bootinfo then?
>
> How are you going to fix it? How is it going to find out where in the vast
> expanses of system memory the bootloader has stuffed the bi_recs? How do you
> code ESP in C?

I guess you didn't get it.  What I meant was to change find_bootinfo to use
r3+KERNELBASE.

Anyway, I don't care.  I'm done with this conversation.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
