From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Samuel Rydh <samuel@ibrium.se>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sycall asm inline
Date: Wed, 19 Jun 2002 05:39:23 +0200
Message-Id: <20020619033923.14394@smtp.wanadoo.fr>
In-Reply-To: <Pine.LNX.4.33.0206200246250.17959-100000@gra-lx1.iram.es>
References: <Pine.LNX.4.33.0206200246250.17959-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I had a patch that did exactly this, but I don't know where it is anymore
>(too many bk trees :-)) Anyway you don't want to see my inline version of
>atomic_clear_mask which selected the best instruction (among rlwinm,
>andi., andis., and andc) through a maze of macros and builtin_constant_p
>(I did this for fun since atomic_clear_mask is almost never used).

It's never used, but should probably be inlined anyway, I just found
a driver that used it and we don't export it to modules...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
