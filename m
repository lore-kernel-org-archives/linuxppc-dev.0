Date: Fri, 4 Feb 2000 19:37:50 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Ani Joshi <ajoshi@shell.unixbox.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] 2.3.42-ppc patch...
In-Reply-To: <Pine.LNX.4.10.10002032158180.18255-200000@shell.unixbox.com>
Message-ID: <Pine.HPX.4.10.10002041845230.1866-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Thu, 3 Feb 2000, Ani Joshi wrote:

>
> hello all, attatched you'll find a patch which should apply to 2.3.41 and
> .42.
>
> this gives ppc the new dyn dma "support" and the stuff for the new rw
> semaphores.
>
>
> any feedback would be appreciated, thanks

Hmmm, about the semaphores: you are basing it on the Alpha port by Andrea
Arcangeli which has been criticized for not using the load with
reservation and conditional store instructions which have AFAICT the same
semantics on Alpha and PPC (and MIPS for the matter). Could you produce a
revised patch when the new Alpha implementation comes out (no need for a
spinlock in the structure) ?

The alpha version was published on the axp-list from what R.Henderson
says, but I have trouble locating it right now.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
