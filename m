Message-ID: <37DCB695.515514B4@wanadoo.fr>
Date: Mon, 13 Sep 1999 10:32:21 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.3.18 and CONFIG_ADB_MOUSE
References: <Pine.LNX.4.10.9909130926130.14721-100000@mercator.cs.kuleuven.ac.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:
> 
> On Mon, 13 Sep 1999, Martin Costabel wrote:
> > Another small nit to pick: The adbmouse driver is offered as a module,
> > but it doesn't compile when CONFIG_ADB_MOUSE=m is selected. The reason
> > is this new
> > __setup("adb_buttons=", adb_mouse_setup);
> > line which is a fallout from the implosion of init/main.c.
> > In <linux/init.h>, __setup is only defined #ifndef MODULE. I don't know
> 
> You have to use the mnoduleparams stuff. Look at de4x5.c for an example.

Don't look at me for this. I'm just a (rather stupid, it seems)
consumer.
 
> > how other drivers handle this problem; in vger-2.3.18, the popular
> > "atyfb=" kernel argument seems to have disappeared completely, for
> > instance.
> 
> There never was an `atyfb=' option. Use `video=atyfb:' instead.

Yes, sorry, and it's parsed in fbmem.c. But I still can't see how atyfb
in 2.3.18 can work as a module. 

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
