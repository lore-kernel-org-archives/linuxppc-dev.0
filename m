Date: Sun, 9 Feb 2003 19:52:14 +0100
To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Low memory on Virtex-II Pro
Message-ID: <20030209185214.GA841@mind.be>
References: <C08678384BE7D311B4D70004ACA37105111946A2@amer22.avnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C08678384BE7D311B4D70004ACA37105111946A2@amer22.avnet.com>
From: p2@mind.be (Peter 'p2' De Schrijver)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 07, 2003 at 02:56:30PM -0700, Kerl, John wrote:
>
> Hello all,
>
> There have been some recent posts about Linux & Virtex-II Pro
> (FPGA with PPC405 hard core).  & apparently people have it working.
>
> One question before I start, though:
>
> Of course the kernel starts at *virtual* address 0xc0000000, regardless
> of the processor.  But my understanding is that certain processors have
> zero-based *physical* addresses for RAM, and some don't -- x86 of course
> being an example of the former, and ARM being an example of the latter.
> I believe that PPC is an example of the former.  Certainly our MPC857T
> board, and all the other boards of which I'm aware, have RAM starting at
> physical address 0x00000000.
>

The 405 has an exception vector pointer register, which is initialized
by linux (linuxppc_2_4_devel cvs tree) with the kernel base. So in
principle it should be possible to have linux run on a system without
memory at address 0. I have never tried this however.

Cheers,

Peter.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
