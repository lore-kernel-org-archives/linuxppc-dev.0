From: Robert Thompson <rothomp3@vt.edu>
To: Hollis Blanchard <hollis@amulet.co.jp>
Subject: Re: trackpad
Date: Wed, 12 Jul 2000 22:43:46 -0400
Content-Type: text/plain
Cc: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        linuxppc-dev@lists.linuxppc.org,
        Benjamin Herrenschmidt <bh40@calva.net>
References: <003b01bfeaa6$744c6e60$1a6a1504@strayer.edu> <008301bfec55$bc40c580$1a6a1504@strayer.edu> <396D5403.23A8B739@amulet.co.jp>
In-Reply-To: <396D5403.23A8B739@amulet.co.jp>
MIME-Version: 1.0
Message-Id: <00071222450300.04224@rothomp3>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 13 Jul 2000, Hollis Blanchard wrote:
>Your problem after disabling the new input layer is most likely because
>/dev/mouse is still a symlink to the new input layer device; you can't
>have it both ways.
>
Nope, that's not the problem.

>If the precompiled kernel doesn't work that suggests there's something
>wrong in your configuration, like your /dev setup or the protocol that X
>and gpm are expecting or the device X and gpm are reading from.
>
Nope, checked that, and that isn't the problem either.

Later,
Robbie Thompson
--
Help Crack RC5! ---> http://www.ccc.vt.edu

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
