Date: Mon, 13 Sep 1999 09:29:01 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Martin Costabel <costabel@wanadoo.fr>
cc: "Joshua M. Thompson" <funaho@jurai.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.18 and CONFIG_ADB_MOUSE
In-Reply-To: <37DC9FFF.5C5A18F7@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9909130926130.14721-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 Sep 1999, Martin Costabel wrote:
> Another small nit to pick: The adbmouse driver is offered as a module,
> but it doesn't compile when CONFIG_ADB_MOUSE=m is selected. The reason
> is this new
> __setup("adb_buttons=", adb_mouse_setup);
> line which is a fallout from the implosion of init/main.c.
> In <linux/init.h>, __setup is only defined #ifndef MODULE. I don't know

You have to use the mnoduleparams stuff. Look at de4x5.c for an example.

> how other drivers handle this problem; in vger-2.3.18, the popular
> "atyfb=" kernel argument seems to have disappeared completely, for
> instance.

There never was an `atyfb=' option. Use `video=atyfb:' instead.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- SONY Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint-Stevens-Woluwestraat 55
Phone +32-2-7248608 Fax +32-2-7242686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
