Date: Sat, 23 Sep 2000 16:08:41 +0200
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: MOL on 2.4/603
Message-ID: <20000923160841.A814@ibrium.se>
References: <20000922164705.32547@mail.mipsys.com> <39CBAA3C.2CC16A34@wanadoo.fr> <39CC3D55.74CD42A2@wanadoo.fr> <20000922223145.B9334@opus.bloom.county> <39CC4642.4291D6A1@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39CC4642.4291D6A1@wanadoo.fr>; from costabel@wanadoo.fr on Sat, Sep 23, 2000 at 07:57:22AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Sep 23, 2000 at 07:57:22AM +0200, Martin Costabel wrote:
>
> Tom Rini wrote:
>
> BTW, now that even the MOL patches have sneaked into Linus' tree, has
> anyone got MOL to work on a 603 with the 2.4.0 kernel? Or what is
> missing?
>

Well, the MOL code in 2.4 has support for 603. However, the MOL
binary does not yet support the 603. (In 2.4, the PTE hash
is gone so MOL must now support the 603 MMU explicitly).

Fixing this is certainly on my todo-list (but so is a lot of other
things - if someone with MMU knowledge and a 603 wants to fix it,
I can give some assistance).

Btw, the lastest released mol version is *not* compatible with
the 2.4 kernel. To run MOL on the 2.4 kernel, pull the latest
version of MOL from the bitkeeper server:

	bk://waltari.theophys.kth.se:5000

Cheers,

/Samuel


----------------------------------------------------------
 E-mail <samuel@ibrium.se>  WWW: <http://www.ibrium.se>
  Phone/fax: (home) +46 8 4418431, (work) +46 8 7908470
----------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
