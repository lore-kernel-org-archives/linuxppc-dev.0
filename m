Message-ID: <3BE1C5D4.713A5F9C@mvista.com>
Date: Thu, 01 Nov 2001 14:59:48 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Dag Nygren <dag@newtech.fi>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: sym53c8xx broke in Bk kernel ?
References: <20011101211901.28548.qmail@dag.newtech.fi>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dag Nygren wrote:

> BTW. Is anyone using the MPC107 ?

Yes.  The sandpoint for one and any other board using an 8240 which has
an almost identical hostbridge/intr ctlr/et. al.

> It is very strange that
> I have to change the Openpic struct in a couple of places to
> get it working on my board.... That shouldn't happen 8-o

You need to start your *linux* IRQ numbering from 16 b/c the EPIC
registers start offset by 0x200.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
