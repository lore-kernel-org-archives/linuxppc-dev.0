Date: Thu, 27 Jan 2000 15:09:26 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Bill Roman <roman@alerton.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc-embedded: main kernel tree
Message-ID: <20000127150926.V14218@hq.fsmlabs.com>
References: <388F3D65.3B420FED@ctam.com.au> <388F18F5.BDE5D395@netx4.com> <00012611055301.05597@alan.corp.packetengines.com> <388F76DF.85E1985E@alerton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <388F76DF.85E1985E@alerton.com>; from Bill Roman on Wed, Jan 26, 2000 at 02:36:15PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The config.in file is not so easy as a bash script.  Bash isn't the only
thing that has to parse the file.  Tcl goes through it on a xconfig as
well.

If you get 2.3.41-pre3 that problem is fixed (it was fixed some time ago).
The latest pre-patch is very close to our ppc tree (with a few differences
I committed just today).  If there's a problem in that tree please do let
us know so we can keep up-to-date with problems.

} As of 2.3.33 (from kernel.org), at lines 88 and 90 in arch/ppc/config.in
} (shortly after "comment 'General setup'"), "else if" should be "elif".  Shell
} scripts are not C :-)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
