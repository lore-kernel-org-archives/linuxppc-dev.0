Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F5F@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Steven Scholz'" <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	PPCBoot <ppcboot-users@lists.sourceforge.net>
Subject: RE: MPC8xx, FEC and DP83847 !?
Date: Thu, 21 Mar 2002 11:56:41 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven,

> I am about to redesign my board and consider to replace Level One's
> LXT971 with National's DP83847.

> Are there any (dis)advantages over the LXT971?

We have experienced many problems using the NS DP83846, on many of our
boards,
even though one model is using the DP83843, and never had problem with it.
We decided to throw away the DP83846 to use the LXT972A instead.
This has fixed many stability problems we have had.

Well, the DP83847 looks more recent, so I can not say about its stability.
We have spent too much effort... :-(

Some advantages for the LXT972A?
- The price was a bit cheaper for us, but that may
  depend on the quantities (I don't have this information).
- The DP83847 can not drive an external IRQ on the PPC, while LXT can.
- The LXT972A can drive 3 LEDs. The LED behavior is easy to configure and
  is very versatile. It perfectly suited our needs, since we use
  only 1 LED to display both the link state and the activity
  (as many hubs do). The DP83847 outputs 6 LEDs with dedicated behavior.
  To combine the link, rx and tx, you need additional hardware.

> Is anyone using National's Phyter DP83846/7 together with MPC8xx FEC?

However, I have added to the 8xx FEC driver the support for the DP83846.
I can give it to you, just ask.

Hope this information helps!

--------------------------------------------
 Jean-Denis Boyer, B.Eng., System Architect
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
