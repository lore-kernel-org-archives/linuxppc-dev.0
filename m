Message-ID: <3E0D222A.FE02C4CD@koffie.nl>
Date: Sat, 28 Dec 2002 05:01:46 +0100
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: "'Paul Mackerras'" <paulus@samba.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: SV: SV: New invalidate/clean/flush_dcache functions
References: <000001c2ade5$5baaa020$94b9143e@hempc>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:
>
> In my typical example I need to invalidate a buffer before I give it to
> the
> CPM to be used as a receive buffer. Once given to the CPM there must be
> no more writes to that buffer memory. When the CPM has received data
> and written the data into the buffer and hands it over to the CPU
> (usally via an interrupt) the next read from the CPU must access it from
> the memory.  Does the above require a sync?

Probably not, I don't know much about the CPM though (and I assume this
is a system without any extra cpu's).

> Does it take some time before a invalidate is completed?

Depends on your cpu; I don't know the details for your cpu.  Check your
manuals :)


Segher


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
