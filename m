To: benh@kernel.crashing.org
Cc: Tom Rini <trini@kernel.crashing.org>,
	Dale Farnsworth <dale@farnsworth.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: MPC5200 Patches 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 Nov 2003 11:44:34 +1100."
             <1069116274.7174.54.camel@gaston>
Date: Tue, 18 Nov 2003 15:45:59 +0100
Message-Id: <20031118144604.65781C5F5F@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Ben,

in message <1069116274.7174.54.camel@gaston> you wrote:
>
> On Tue, 2003-11-18 at 11:43, Benjamin Herrenschmidt wrote:
> > I only ever got DMA reads to work, DMA writes never kicked the
> > BestComm task..
>
> Argh... I hate that evolution bug that when you remove the
> signature,  it deletes 2 random lines of text...
>
> So I was asking if you had the IDE DMA working correctly since
> I see that you have my code in there.

This is still your unmodified code. We're working  with  Motorola  on
this  issue,  but  it  was assigned lower priority because of other,
more pressing issues.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Swap read error.  You lose your mind.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
