Date: Wed, 27 Mar 02 10:32:42 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203271832.AA04627@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> Yeah, that's right, I messed up.  So what should be done for the nested ones?
> What is we use the BI_DEVICE as a quasi-BI_FIRST and then add a BI_LAST to each
> nested one?  This is what it would look like:

I think the whole idea of nested bi_recs is completely unnecessary complexity.
A simple BI_GT64260_ETH_CFG is better.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
