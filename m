Date: Fri, 23 Aug 2002 15:13:47 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: John Fisher <John.Fisher@nec.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cygwin and embedded linux
In-Reply-To: <Pine.LNX.4.40.0208220914420.2118-100000@mag.devdep.sysgo.de>
Message-ID: <Pine.LNX.4.40.0208231506060.12655-100000@mag.devdep.sysgo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 22 Aug 2002, I wrote:

> 2. The "emulation" will never be 100%. Maybe 99%. Maybe 99.99%. That last
>    fraction can be a major PITA, because it is not obvious. To compile a
>    kernel you need a lot of tools with a lot of explicit and implicit twists
>    to them. It is just a gut feeling that I wouldn't want to rely on this,
>    if I don't have to. The native way just seems the better way to do it to
>    me.

Since the term "native" seems to have triggered many other (very
interesting) posts, just for completeness: in fact I chose bad wording
for what I wanted to say in this post. In this case, with "native" I
merely meant a real Linux box (vs. a Windows box), not necessarily a
native ppc-linux machine.

Native ppc-linux is definitely one way to go, although I'd tend to
hold with one of the other posts to this thread. It pointed out the
necessity/robustness/repoducability/beauty of clearly distincting
between the host and the target.

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions GmbH     mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
