Date: Tue, 25 May 2004 17:00:41 -0700
From: Jamie Heilman <jamie@audible.transient.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BriQ & Linux 2.6
Message-ID: <20040526000040.GY1946@audible.transient.net>
References: <20040521074018.GD8520@audible.transient.net> <1085181034.6755.7.camel@gaston> <20040521233523.GJ8520@audible.transient.net> <1085199239.9230.4.camel@gaston> <20040522064520.GM8520@audible.transient.net> <1085527853.15024.141.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1085527853.15024.141.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> Picked this patch somewhere, let me know if it helps for the bogus
> Tx errors. I don't know what's up with the lockup at this point, I
> would expect the machine to be stable. Can you try to exercice it
> using only netbooting instead of the HD or switching the HD down
> to PIO mode (hdparm -d0 /dev/hda) to try to isolate the source of
> the problem ?

Ah cool, thanks I'll give it a try.  It'll be a while though, I just
accepted a job out of state, so I'm starting the moving process and
one of the first things I did was stick the briq back in its box.
It'll probably be a month before I'm ready to pull it out again, but
I'll let you know how it goes when I do.

--
Jamie Heilman                     http://audible.transient.net/~jamie/
"Paranoia is a disease unto itself, and may I add, the person standing
 next to you may not be who they appear to be, so take precaution."
						-Sathington Willoughby

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
