Date: Wed, 27 Mar 02 10:34:20 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203271834.AA04642@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> I messed up the size on the BI_LAST struct, should be 12.  Attempt #5:

BI_FIRST and BI_LAST are normally dataless (size 8), but the parser doesn't
care.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
