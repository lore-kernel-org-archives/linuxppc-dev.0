From: Benjamin Herrenschmidt <bh40@calva.net>
To: Dan Malek <dan@netx4.com>, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
Date: Thu, 31 Aug 2000 18:19:17 +0200
Message-Id: <20000831161917.24142@mailhost.mipsys.com>
In-Reply-To: <39AE80BD.D86B34DA@embeddededge.com>
References: <39AE80BD.D86B34DA@embeddededge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Yeah, well, I am used to continually losing this battle.  Although
>embedded PowerPC is likely to have _lots_ more installations than
>the desktop, we'll just survive on the pieces left behind.  A pretty
>running desktop gets lots of press coverage while code that acutally
>runs the infrastructure of the world is unknown (I guess we are doing
>a great job, then :-).
>
>I am just happy that I can finally build a kernel for the MPC8xx that
>doesn't require I configure an ADB keyboard.  I also like building the
>same sources for all of my Mac workstations and servers as well.

In the current bk, I made sure you can compile without ADB (even for
pmac), without the backlight stuffs, etc...

>I would also like to see us spend a little more time trying to
>stabilize 2.4 instead of trying to solve elaborate configuration and
>boot schemes.  That is what 2.5 is for.

Agreed.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
