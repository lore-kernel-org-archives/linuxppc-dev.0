Date: Tue, 19 Mar 02 17:02:56 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0203200102.AA08371@ivan.Harhan.ORG>
To: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: EV-64260-BP & GT64260 bi_recs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark A. Greer <mgreer@mvista.com> wrote:

> Man, can I ever turn a quiet email day into a hurricane!!  :)

Ever heard the term filibuster? That's what I think happening here: lots of
talk, no work. Also note that so far I'm the only one who has posted a patch,
the rest is verbiage.

> Point well taken and you're right, perhaps the cmd_line is a better way to
> pass in hdx/fdx & speed, phy addr & is_rmii.

The PHY address and MII vs. RMII are things fixed by board circuitry and would
normally be hard-coded. The only reason I added them to BI_GT64260_ETH_CFG was
because I imagined the #ifdef maze that would otherwise eventually grow in the
gt64260_eth driver as people add ports to different boards with these things
wired differently.

As for speed, etc. no other driver I know of requires the bootloader to pass
this info. It's normally set by ethconfig, miitool, etc. Please don't add that
in there, I have no slightest idea what to put in those fields if they were in
the bi_rec.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
