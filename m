Date: Tue, 30 May 2000 09:03:01 -0700
From: Matthew Locke <mlocke@jps.net>
Subject: RE: rpx_cfg() copy to NVRAM?
In-reply-to: <Pine.LNX.3.96.1000530110746.8009A-100000@tristar.cc.absoval.com>
To: "Mark S. Mathews" <mark@absoval.com>, linuxppc-embedded@lists.linuxppc.org
Message-id: <NDBBJCEBJMJJJBIMCFBEOEDJCDAA.mlocke@jps.net>
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I'm in the process of changing head.S and embed_config.c to work with the
> new EP bootloader.

Why?  You don't need to change anything.  There are two configuration
variables in the eeprom that need to be set.
SYPCR needs to be set to turn the watchdog off. Can't remember the value and
I don't have the docs in front of me.
NVRAM needs to be set to non-zero, even if the board doesn't have any nvram.

I don't think this info was sent to the beta-testers, sorry.

Matt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
