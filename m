Date: Mon, 21 Jun 2004 08:58:25 +0200
From: Marc Leeman <marc.leeman@barco.com>
To: jmartin <jmartin@prodys.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8xx idma
Message-ID: <20040621065825.GO10248@smtp.barco.com>
Reply-To: Marc Leeman <marc.leeman@barco.com>
References: <006f01c45533$21e7d0f0$2700000a@jmartin>
Mime-Version: 1.0
In-Reply-To: <006f01c45533$21e7d0f0$2700000a@jmartin>
Content-Type: text/plain; charset=iso-8859-15
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> i think problem is fec sdma and idma working simultaneously. Exists
> any problem if sdma and idma are working together?

Could you be a tad more precise, which DSP and what revision? Since I
know Prodys is working with TI DSPs, you might want to look into the
silicon bug lists. With certain TI DSP, you will not be able to use DMA
initiated by the PPC.

Been there done that ;)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
