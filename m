Message-Id: <200112072209.OAA24682@dt096n14.san.rr.com>
Date: Fri, 7 Dec 2001 14:09:13 -0800 (PST)
From: Greg Noel <GregNoel@san.rr.com>
Subject: Re: NVRAM stuck in DST?
To: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200112070759.IAA00984@piglet.grunz.lu>
References: <200112070759.IAA00984@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 7 Dec 2001 08:59:14 +0100 (CET) Michel Lanners <mlan@cpu.lu> wrote:

>If not, then I'll be stuck with whatever NVRAM values MacOS wrote there
>when it was last booted. Which means that unless at every DST time
>change, unless I bo[o]t MacOS once, I'll be stuck with the wrong time....

One way to keep your UNIX clock correct is to run NTP; see www.ntp.org.
Then the only problem is that it no longer seems possible to get MOL to
synchronize with the UNIX clock, but that's another issue...

Hope this helps,
-- Greg Noel, retired UNIX guru


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
