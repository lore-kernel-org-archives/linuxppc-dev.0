Date: Mon, 13 Sep 1999 10:54:20 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Martin Costabel <costabel@wanadoo.fr>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.18 and CONFIG_ADB_MOUSE
In-Reply-To: <37DCB695.515514B4@wanadoo.fr>
Message-ID: <Pine.LNX.4.10.9909131052210.14721-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 Sep 1999, Martin Costabel wrote:
> Geert Uytterhoeven wrote:
> > On Mon, 13 Sep 1999, Martin Costabel wrote:
> > > Another small nit to pick: The adbmouse driver is offered as a module,
> > > but it doesn't compile when CONFIG_ADB_MOUSE=m is selected. The reason
> > > is this new
> > > __setup("adb_buttons=", adb_mouse_setup);
> > > line which is a fallout from the implosion of init/main.c.
> > > In <linux/init.h>, __setup is only defined #ifndef MODULE. I don't know
> > 
> > You have to use the mnoduleparams stuff. Look at de4x5.c for an example.
> 
> Don't look at me for this. I'm just a (rather stupid, it seems)
> consumer.

Well, someone should fix the adbmouse driver...

> > > how other drivers handle this problem; in vger-2.3.18, the popular
> > > "atyfb=" kernel argument seems to have disappeared completely, for
> > > instance.
> > 
> > There never was an `atyfb=' option. Use `video=atyfb:' instead.
> 
> Yes, sorry, and it's parsed in fbmem.c. But I still can't see how atyfb
> in 2.3.18 can work as a module. 

I have to admit I never tried to use it as a module yet. I plan to do that,
though. When loaded as a module, it will use the default video mode.

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- SONY Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248620 Fax +32-2-7242686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
