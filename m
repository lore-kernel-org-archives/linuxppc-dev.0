Date: Wed, 27 Mar 02 10:03:44 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203271803.AA04513@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> Okay, this may be it, attempt #4:

Looks fine, except for:

> [6] 0x00000000                          (NULL Termination of whole list)

Currently the entire bi_recs list starts with BI_FIRST (that's how we detect a
bi_recs list) and ends with BI_LAST (that's the terminator). We must maintain
compatibility.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
