Date: Mon, 23 Apr 2001 18:15:50 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Alexandre.Nikolaev@matrox.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ppc little-endian port
Message-ID: <20010423181550.F13368@ftsoj.fsmlabs.com>
References: <3AE47B3C.8DF8F330@matrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AE47B3C.8DF8F330@matrox.com>; from anikolae@matrox.com on Mon, Apr 23, 2001 at 02:58:04PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Why?

} This is a port of Montavista's 2.4.0-test2 kernel to ppc running in
} Little-Endian.
} As a base, we used Sandpoint configuration, but disabled some irrelevant
} code for our board (these changes are not in the patch).
} We made it just for a board with CPU and RAM only, so if you want to use
} anything extra (drives, PCI, etc.)
} you have to look at the corresponding code and make changes accordingly
} (if needed). Additionally, if you use different configuration scheme
} (not sandpoint), you might have to do some other changes.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
