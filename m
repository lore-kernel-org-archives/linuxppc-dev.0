Subject: Re: BDI-2000
From: Hollis Blanchard <hollis@austin.ibm.com>
To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <885489B3B89FB6449F93E525DF78777F064531@srvnt506.ALLOPTIC.COM>
References: <885489B3B89FB6449F93E525DF78777F064531@srvnt506.ALLOPTIC.COM>
Content-Type: text/plain
Date: 08 Jan 2003 10:20:33 -0600
Message-Id: <1042042834.1207.86.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 2003-01-07 at 18:40, Muaddi, Cecilia wrote:
>
> BDI>info
>     Target state      : debug mode
>     Debug entry cause : entering check stop state
>     Current PC        : 0x00000220

You seem to have caused a machine check. For clues look at SRR0 and
SRR1, as well as any other registers your CPU sets on machine check (I
don't know 8xx - look in your user manual for information on machine
checks).

-Hollis
--
PowerPC Linux
IBM Linux Technology Center


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
