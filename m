Message-ID: <39590837.29E8FE30@aiinet.com>
Date: Tue, 27 Jun 2000 16:01:59 -0400
From: Matt Gessner <mattg@aiinet.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260, FCC and local bus
References: <3958BBF1.20E543AB@aiinet.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Gessner wrote:
>
> Hello list,
>
> Has anyone done anything with mapping local bus memory
> so that it can be used for FCC BD's and buffers?
>
> I **thought** I had it right, but my driver eventually
> causes the machine to hang (EST SBC8260).
>
> I had ioremap'd it, and put va's and pa's where each belonged
> (va's for the kernel's tracking stuff and pa's for the CPM stuff).
>
> Alas, to no avail.
>
> Has anyone had any success with this, and if so, would you be
> willing to share?
>
> TIA,
>
> --
> Matt Gessner, mattg@aiinet.com--NOSPAM
> Senior Software Engineer, R&D
> Applied Innovation, Inc.
> 614-798-2000
>

Sigh.

Check RSTATE and TSTATE (for FCRx) .

Thanks anyway.
--
Matt Gessner, mattg@aiinet.com--NOSPAM
Senior Software Engineer, R&D
Applied Innovation, Inc.
614-798-2000

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
