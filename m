Date: Wed, 8 Mar 2000 16:27:46 +0100
From: enneper <cesli@ewetel.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Booting 2.3.48 (devel) kernel problems?
Message-ID: <20000308162745.A381@gmx.li>
Reply-To: enneper@gmx.net
References: <20000308151946.024345@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000308151946.024345@mailhost.mipsys.com>; from Benjamin Herrenschmidt on Wed, Mar 08, 2000 at 03:19:46PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



 Benjamin Herrenschmidt }  I think it worked with OF because we inherit from OF SDR1 and, by luck,
 Benjamin Herrenschmidt }  OF page tables are high enough in memory to not have been damaged by the

yes, 2.3.48 works with 3400-OF

there are three things so far:
-OF complains past the standart
	ok
	copying OF device tree ...done
 about:
	Initialising fake screen
	Failed to get address
 but lets linux make its way

-in something like mutt in aterm, colours and fonts scramble for their rights at the bottom of the window with a very useless result, a bit annoying.

-pcmcia compiles with:
i82365.c:110: warning: `do_scan' defined but not used
i82365.c:553: warning: `test_irq' defined but not used
i82365.c:737: warning: `add_socket' defined but not used
i82365.c:748: warning: `add_pcic' defined but not used
i82365.c:1499: warning: `init_i82365' defined but not used
i82365.c:1543: warning: `exit_i82365' defined but not used
but gets massive pci problems, so no driver is loaded.

greetings
Claus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
