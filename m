In-Reply-To: <200001201826.NAA25092@mal-ach.watson.ibm.com>
Date: Thu, 20 Jan 2000 19:45:07 +0100
To: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Fwd: Re: still no accelerated X ($#!$*)
Message-Id: <20000120194507.014220@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 20, 2000, David Edelsohn <dje@watson.ibm.com> wrote:

>	The "b" constraint should be associated with "base_addr", not with
>"regindex":
>
>	asm("stwbrx %0,%1,%2": : "r"(regdata), "r"(regindex), "b"(base_addr));

Hum... I still have to check what gcc/ppc specific constraints are. But
in this specific case, it's the index who should not be assigned to r0.
Both base and regdata can be r0. So either I'm mising something, or the
"b" constraint is actually wrong semanticall, or we need yet-another
constraint for the index.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
