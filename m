Date: Tue, 11 Feb 2003 09:33:56 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: [PATCH] 8xx_io/uart.c
In-reply-to: <20030210172530.GA20757@ip68-0-152-218.tc.ph.cox.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: "Ruhland, Paul" <PRuhland@microwavedata.com>,
	linuxppc-embedded@lists.linuxppc.org
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLIECIFKAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Bring it up on linux-kernel@vger.kernel.org.  A brief description and
> this patch should be enough to get people to listen.  Maybe send it to
> Alan Cox too..

Yep, this needs to be discussed elsewhere. I have received some comments
and these suggests that opost() can be executed in interrupt context so
something else (non trivial) needs to be done.

 Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
