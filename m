Date: Thu, 11 Apr 2002 16:10:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: andrew may <acmay@acmay.homeip.net>
Cc: Armin <akuster@pacbell.net>, John Tyner <jtyner@cs.ucr.edu>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] early serial init
Message-ID: <20020411231056.GJ759@opus.bloom.county>
References: <Pine.LNX.4.30.0204111424410.10803-100000@hill.cs.ucr.edu> <3CB5A370.4080409@pacbell.net> <20020411153642.C18158@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020411153642.C18158@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Apr 11, 2002 at 03:36:42PM -0700, andrew may wrote:

> This patch is to remove the need for the BASE BAUD define.

Only if you get this information from somewhere else, yes?  This isn't
currently something we grab from OpenBIOS, or could, right?

> If we ever start
> trying to get a single kernel to build for multiple 405 boards that run at
> various clock rates it becomes helpful to calc the base baud for the serial
> ports rather than forcing it at compile time.

If we ever start trying to get a single kernel to build for multiple 405
boards something has gone wrong. :)

More seriously, if someone wants to try and do that there's lots of
other things which would need to be changed first.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
