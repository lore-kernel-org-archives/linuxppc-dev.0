To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: modules/dma/physical address
References: <38C7A27D.2E982D60@col.bsf.alcatel.fr>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 13 Mar 2000 11:13:57 +0100
In-Reply-To: duyrat1's message of "Thu, 09 Mar 2000 14:09:17 +0100"
Message-ID: <kfyityrqisa.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


duyrat1 <duyrat1@col.bsf.alcatel.fr> writes:

> Hy everybody,
>
> I think I have found a little source of bug, so please correct me if I
> am wrong :
>
> Every time we use a dma on the mpc860, we've got to give him the
> physical address
> of a buffer ( the physical addr of a sk_buff in enet.c for exemple ).
> We use __pa which purpose is just to  substract 0xc0000000.
> But when we create a buffer in a module, his virtual addr is not just an
> offset of his physical addr,

Yes it is, if you use __pa on addresses it is intended to be used on.
(Well, to be precise __pa should never be used in drivers at all, you
should use virt_to_phys instead, but in the end they do the same thing
on PPC)

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
