Date: Tue, 6 Apr 2004 09:37:41 +0200
From: Kiko Piris <linuxppc@pirispons.net>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.6.5/iBook G3: Oops on resume from sleep
Message-ID: <20040406073741.GA4008@fpirisp.portsdebalears.com>
References: <20040405215318.GA2822@mortadelo.pirispons.net> <20040405231321.GA1293@palantir8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040405231321.GA1293@palantir8>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 06/04/2004 at 00:13, Martin Habets wrote:

> What sound chip do you actually have? The kernel seems to think
> you have a snapper.
> You can find out with
> cat /proc/asound/cards
> after ALSA is loaded.

It seems I do:

---8<---
0 [Snapper        ]: PMac Snapper - PowerMac Snapper
                     PowerMac Snapper (Dev 24) Sub-frame 0
--->8---

> This capture_source thing was added pretty recently.

I don't quite understand you, sorry.

--
Kiko

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
