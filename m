Date: Fri, 16 Jan 2004 17:44:30 +0100
From: valvoline <valvoline@vrlteam.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] therm_* drivers need i2c-keywest
Message-ID: <20040116164430.GV2658@adapter.n0skillz.org>
Reply-To: valvoline@vrlteam.org
References: <20040116122756.034fc736.colin@colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040116122756.034fc736.colin@colino.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jan 16, 2004 at 12:27:56PM +0100, Colin Leroy wrote:


> This patch lets the different pmac thermostat drivers try to load i2c-keywest if necessary and possible.

the patch works fine against the soundcore/i2c_west modprobing problem,
which i've talk about some threads ago.

what's about /dev/ entries ?, i still see nothing into it...the only infos
that i can fetch are into /var/log/syslog.

If i don't make a mismatch, there should be some /dev entries that the
module should create, usefull to set/fetch important informations about
fans/cpu.

regards
--
[ valvoline :: VRL Team :: s0ftpj :: freaknet Medialab :: GPG key available  ]
[ key fingerprint :: - :: B7E2 48BC 705F AE8F 9ABE  E422 076A 2561 1D67 B4DD ]
[ GPG key available on keyserver :: pgp.mit.edu :: with keyID :: 1D67B4DD :: ]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
