Date: Mon, 28 Oct 2002 00:23:46 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dc* (Data Cache)  instructions in mem*() and *_page() functions
 not used on 8xx
In-reply-to: <IGEFJKJNHJDCBKALBJLLMEGFFHAA.joakim.tjernlund@lumentis.se>
To: linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLAEGMFHAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It's me again

No response so far. Trying again.

     Jocke
>
> Hi again
>
> I trying to understand how the different mem*() and *_page() functions in arch/ppc/kernel/misc.S
> and arch/ppc/lib/string.S works wrt data cache.
>
> I found that on 8xx these are not used. Why? Are there 8xx variants that can't handle them?
> Do 860 work with these?
>
> Also, why is not dcbtst(write a cache line) used
> in the different copy functions, copy_page()for example, instead of the COPY_16_BYTES macro?
>
>   Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
