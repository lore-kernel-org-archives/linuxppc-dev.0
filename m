Date: Wed, 15 May 2002 08:52:00 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David M?ller (ELSOFT AG)" <d.mueller@elsoft.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] Several patches agains linuxppc_devel-2.4.19-pre8
Message-ID: <20020515155200.GN721@opus.bloom.county>
References: <3CE2481B.5070108@elsoft.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CE2481B.5070108@elsoft.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 15, 2002 at 01:35:55PM +0200, "David M?ller (ELSOFT AG)" wrote:

> The attached patch fixes the following issues:

Looks good, except:
Don't #ifdef externs, if they aren't used it's OK.
Since this code only has to work in recent'ish kernels (in reality only
'current' kernels) don't bother with the
#ifdef MODULE_LICENSE
...
#endif

Just use it.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
