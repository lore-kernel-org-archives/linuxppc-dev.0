Date: Mon, 31 Dec 2001 08:32:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Bob Piatek <bobtek@fishcamp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: unresolved symbol
Message-ID: <20011231153213.GB28513@cpe-24-221-152-185.az.sprintbbd.net>
References: <000001c19196$da8c6340$a2341204@P4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000001c19196$da8c6340$a2341204@P4>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, Dec 30, 2001 at 05:02:43PM -0800, Bob Piatek wrote:

> When attempting to load a module via 'insmod' I get the following:
>
> insmod unresolved symbol kmalloc
> insmod unresolved symbol unregister_chrdev
> insmod unresolved symbol register_chrdev
> ...
> insmod unresolved symbol printk
>
>
> It seems that there was another person with the same problem on Sept 24,
> 2001 to this list.  However, the solution to the problem was not posted
> to the list.

It sounds like you're running YellowDog Linux 2.0, and thus need to
install the modutils update.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
