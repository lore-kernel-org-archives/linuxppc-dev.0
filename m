Date: Thu, 15 May 2003 12:01:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] educate users about x86 specific kludges instead of hiding thier ignorance
Message-ID: <20030515190158.GD11565@ip68-0-152-218.tc.ph.cox.net>
References: <20030515074214.GA787@plato.local.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030515074214.GA787@plato.local.lan>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 14, 2003 at 11:42:14PM -0800, Ethan Benson wrote:

> the phony bzImage target in the ppc Makefiles is not helping anything,
> rather it just changes the confusion from `why doesn't make bzImage
> work?' to `where is my bzImage?'
>
> lets not hide users ignorance lets teach them instead.  the attached
> patch replaces the phony bzImage target with a error explaining that
> bzImage is x86 only and to use zImage instead.
>
> please apply.

I agree that it's a stupid thing to do (and, btw, 'bzImage' on m68k is,
or was anyhow, a bzip2 image adding to the fun) but this came in,
intentionally, from Paul exactly because the system said 'Now use make
bzImage'.  Maybe this can die in 2.5, but I haven't paid attention in
some time.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
