Subject: Re: VGA out/External Monitor on ibook 2
From: Owen Stampflee <owen@stampflee.com>
To: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030120155921.GA22300@haar.ae.gatech.edu>
References: <20030120155921.GA22300@haar.ae.gatech.edu>
Message-Id: <1043086974.2456.9.camel@tsunami.lan.stampflee.com>
Mime-Version: 1.0
Date: 20 Jan 2003 10:22:54 -0800
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> case 1: Monitor connected at boot up
> The external monitor is fine at depth 8, resolution 1024x768-8@60Hz.
> Changing the depth (text mode) with fbset makes the font look like the
> wrong depth. It feels like font depth has changed but not the display
> depth. The internal-LCD display stays just fine.

Starting X will screw up the secondary display in this scenario too.

> Has this been solved? If not, how can I help?

Nope. I wrote some tools to dump the Rage128's config registers as well
the PLL but haven't had a chance to actually get dumps.
Anyways, its located at http://www.stampflee.com/r128dump

It would useful for dumps (send them to me, not the list...) booting
with both the scenarios you provided and when booting with
"video=ofonly"

Owen

--
Owen Stampflee - owen@stampflee.com - http://www.stampflee.com
GnuPG Fingerprint: EDE6 48EC 4E65 BE83 D405  B091 B170 8AF0 F875 65E0
Download My Public Key: http://www.stampflee.com/owen.asc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
