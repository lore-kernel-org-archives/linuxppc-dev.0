Message-Id: <200003170652.BAA02096@shell.faradic.net>
Date: Thu, 16 Mar 2000 20:52:10 EST
From: jingai <jingai@floatingpenguins.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: USB keyboard lights & kernel 2.3.52 (paul's)
Reply-To: jingai@floatingpenguins.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I finally was able to get Paul's tree to run on my box tonight (2.3.52), and
all seems great, except for two things:

1) My USB keyboard's lights have gone wacko.  In 2.3.39 and below, they
didn't light up at all (num lock, scroll lock, caps lock), but in 2.3.52,
when caps lock is toggled, the num lock light lights up instead, and I have
yet to figure out what toggles the other two :)  not a major problem, just
an oddity.

2) The other problem is that netfilter 0.1.18 no longer builds -- I'm
guessing this is due to a change in the kernel headers and we'll probably
see a new netfilter release soon, but I figured I'd mention it anyway.

Last question:  since my work schedule has been so hectic, I haven't been
actually following the threads on XFree86 4.0, so I'm just curious... does
it currently build on PPC boxes?  And does it support accelerated video
with the ATI RagePro, or do is this a good reason for me to go out and
actually buy a Rage128 :)

Thanks in advance,
Jonathan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
