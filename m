Date: Mon, 24 Apr 2000 12:54:23 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: feature_init
Message-ID: <20000424125423.Z1544@medea.fsmlabs.com>
References: <3903A49C.B0BB90EB@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3903A49C.B0BB90EB@embeddededge.com>; from Dan Malek on Sun, Apr 23, 2000 at 09:34:20PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


CONFIG_PREP, CONFIG_CHRP and CONFIG_PMAC are gone in 2.3.  They've been
replaced with CONFIG_ALL_PPC.  It's a bad name, I know, but it was already
in place.  In 2.5 (perhaps 2.4 after testing) I was going to rename it and
clean up the dependencies based on that a bit.

} OK.  I did it.  The feature_init call in setup.c is only relevant to OF
} machines, so I put a CONFIG_ALL_PPC around it.  Then it hit me (it
} hasn't happened in a while :-)........Does this mean CONFIG_PREP,
} CONFIG_CHRP, CONFIG_PMAC are becoming obsolete?  They seem to be
} combined now.  Maybe this is why I can't build a kernel for my Macs
} because I still select PowerMac instead of "all PPC"?
}
} Guess I'll go chase some Easter Bunnies......

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
