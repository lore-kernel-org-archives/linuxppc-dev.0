From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PATCH: improved processor config for G3s
Date: Tue, 5 Sep 2000 12:50:25 +0200
Message-Id: <20000905105025.300@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10009041309060.15438-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10009041309060.15438-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The absence of broadcast might definitely harm, but first the support for
>store gathering in the MPC106 (Grackle) is quite poor:
>
>"For a stream of single-beat writes, the data for the first transaction is
>latched in the first buffer and the MPC106 initiates the transaction on
>the PCI bus. The second single-beat write is then stored in the second
>buffer. For subsequent single-beat writes, store gathering is possible if
>the incoming write is to sequential bytes in the same half cache line as
>the previously latched data. Store gathering is only used for writes to
>PCI memory space, not for writes to PCI I/O space. The store gathering
>continues until the buffer is scheduled to be flushed or until the
>processor issues a synchronizing transaction.

Well, that would help unaccelerated frame buffers (but are there any on
Grackle-based machines ?)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
