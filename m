Subject: Re: [PATCH] MPC85XX TSEC driver: fix for mdio speed
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Andy Fleming <afleming@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <6429F663-D53A-11D8-8835-000393C30512@freescale.com>
References: <22C48749-C9D2-11D8-B201-000393DBC2E8@freescale.com>
	 <6429F663-D53A-11D8-8835-000393C30512@freescale.com>
Content-Type: text/plain
Message-Id: <1089788421.5959.15.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Date: Wed, 14 Jul 2004 09:00:21 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-07-14 at 04:06, Andy Fleming wrote:

> Ooh, good catch.  Kumar Gala forwarded me this, since I wrote the
> driver (And now I have subscribed to linuxppc-embedded, as I should
> have ;).  Rather than a dummy read, though, it might be better to

You're actually a bit late, seems the list won't exist much longer... :(

> abstract the code which configures the bus, and put it in a function
> that both get_phy_info and phy_run_commands can call.
>
> Here's a patch that does that.  Could you check that it fixes your
> problem?  If so, we'll push it out.
>

Works like a charm.

I just added some "volatile"s, the compiler was complaining.
You also may want to move that cast to struct gfar * into get_phy_bus().
>
> ______________________________________________________________________
> Sorry for the long delay:  this window fell behind some others while I
> was investigating a couple of the other things you mentioned, and then
> my stack got corrupted.

Well, at least it's good to know that somebody's working on it :)

Btw: Can support for the 8541 be expected anytime soon?
     I added some #defines to my platform code, but I didn't look
     closely into it's incarnation of the CPM yet.

--
Stefan Nickl
Kontron Modular Computers


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
