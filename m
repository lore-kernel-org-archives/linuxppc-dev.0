Date: Tue, 6 Nov 2001 17:56:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Subodh Nijsure <subodh@best.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compiling kernel with -g option.
Message-ID: <20011106175621.A4528@cpe-24-221-152-185.az.sprintbbd.net>
References: <200111070012.QAA23022@shell9.ba.best.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200111070012.QAA23022@shell9.ba.best.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Nov 06, 2001 at 04:12:13PM -0800, Subodh Nijsure wrote:

> Sorry if this is "basic" question but I looked through mailing and couldn't
> find a solution.
>
> When I compile kernel and some of my own modules together I get tons
> of error like --
[snip]
> However if I compile everything with -O2 options everything works fine,
> any way I can fix this so I can debug things....

Did you try to use just -g ?  (Ie not -O2 -g ...).  You _need_ at least
-O1 to compile a kernel.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
