In-Reply-To: <Pine.LNX.4.60.0408060912370.7391@localhost.localdomain>
References: <20040806081151.B77FCC109F@atlas.denx.de> <411369F9.5060506@rossvideo.com> <884A8F94-E7A5-11D8-9B14-003065F9B7DC@embeddededge.com> <Pine.LNX.4.60.0408060912370.7391@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6BE5CAC1-E7AF-11D8-9B14-003065F9B7DC@embeddededge.com>
Cc: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>,
	Ralph Siemsen <rsiemsen@rossvideo.com>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Init hangs
Date: Fri, 6 Aug 2004 09:49:22 -0400
To: "Robert P. J. Day" <rpjday@mindspring.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Aug 6, 2004, at 9:14 AM, Robert P. J. Day wrote:

> thanks for that tidbit.

Trivia time.  The reason I did that many years ago when first ported
the 8xx
was I had only 6xx tools and libraries available.  Even though you don't
have any floating point in your program, things like initialization,
set/longjmp,
signals and so on would assume an FPU was available.  So, I just
trapped those few FP load/store instructions.  Later on, I did the whole
math emulation thing.  Of course, today the best solution is a
development
kit specific to the 8xx that has applications and libraries already
properly
compiled.  Without math emulation enabled, you still get those few
trivial traps emulated.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
