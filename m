Date: Mon, 9 Jun 2003 14:44:20 +0900
Subject: Re: Wrong BAT mapping message in dmesg
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: Etsushi Kato <ekato@ees.hokudai.ac.jp>
In-Reply-To: <Pine.GSO.4.21.0306060837351.864-100000@vervain.sonytel.be>
Message-Id: <6AB54C74-9A3D-11D7-ABA8-00039394E428@ees.hokudai.ac.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 2003.6.6, at 03:38  PM, Geert Uytterhoeven wrote:

> Do you have any more drivers or driver fixes that are important for
> Mac/m68k
> users as well (both 2.4.x and 2.5.x)?

Although I'm not familiar with mac/m68k, I don't think there is such a
important thing.

Some minor things; typo in mac8390.c about MODULE_LICENSE
(MODUEL_LICENSE in original source), and Foucus MV-16EN ethernet card
for PowerBook support with smc9194.c.

Cheers,
--
Etsushi Kato
ekato@ees.hokudai.ac.jp


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
