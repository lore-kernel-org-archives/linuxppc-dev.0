Reply-To: <joakim.tjernlund@lumentis.se>
From: "Joakim Tjernlund" <joakim.tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: dc* (Data Cache)  instructions in mem*() and *_page() functions not used on 8xx
Date: Fri, 25 Oct 2002 18:02:12 +0200
Message-ID: <IGEFJKJNHJDCBKALBJLLMEGFFHAA.joakim.tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <02102313444201.01073@scop.digitel.com.br>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi again

I trying to understand how the different mem*() and *_page() functions in arch/ppc/kernel/misc.S
and arch/ppc/lib/string.S works wrt data cache.

I found that on 8xx these are not used. Why? Are there 8xx variants that can't handle them?
Do 860 work with these?

Also, why is not dcbtst(write a cache line) used
in the different copy functions, copy_page()for example, instead of the COPY_16_BYTES macro?

  Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
