From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Halfmann, Klaus" <Klaus.Halfmann@bauer-partner.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Console not appearing with iBook and 2.4.8-pre8
Date: Fri, 10 Aug 2001 21:43:40 +0200
Message-Id: <19031231212357.13650@smtp.wanadoo.fr>
In-Reply-To: 
 <2C5637A6A7CE844EA3C0A94565479F520B470B@dest-as20-002.int.bauer-partner.com>
References: 
 <2C5637A6A7CE844EA3C0A94565479F520B470B@dest-as20-002.int.bauer-partner.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>This morning I build a fresh kernel from the bk-repository
>on my (old) iBook. I did a
>
>	make oldconfig depend vmlinux modules modules_install
>
>When booting the last message is the "prom_init" message
>in the yaboot screen. After that no console appears.
>Everything else seem fine. I can blindly login as
>root and reboot the system. As I remember, this started
>a few days ago, I think with 2.4.8-pre6.
>
>(Now, while writing about this, I think tonight Ill do
> a "make clean" and try again. )

Make sure you enable the new atyfb in the config.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
