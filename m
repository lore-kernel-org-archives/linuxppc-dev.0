Date: Tue, 18 Sep 2001 10:51:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Armin Kuster <akuster@mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Got Time
Message-ID: <20010918105143.E31595@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BA77FA8.E317D5B8@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA77FA8.E317D5B8@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 18, 2001 at 10:08:56AM -0700, Armin Kuster wrote:

>  here is a patch that returns the ability to enable the realtime clock
> on the 4xx

Close enough.  We can just remove the CONFIG_4xx check totally.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
