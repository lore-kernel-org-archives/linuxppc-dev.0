Date: Wed, 9 Oct 2002 19:26:26 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.terrasoftsolutions.com
Subject: Re: Status of 2.5.X kernels on PPC Linux, anyone working with NPTL?
Message-ID: <20021010022626.GB1967@opus.bloom.county>
References: <8B16CEB0-DB99-11D6-BCE2-0030654D6A26@ivey.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8B16CEB0-DB99-11D6-BCE2-0030654D6A26@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Oct 09, 2002 at 11:12:36AM -0400, Kevin Hendricks wrote:

> Hi,
>
> Can anyone bring me up to date on the buildability and useability of the
> latest 2.5.X kernels on PPC Linux?  How stable and useful are these
> given the recent changes to revert back to 2.4 IDE code and other
> changes?

Depending on the time and day of course, the linuxppc-2.5 tree is
generally left in a buildable state, at least for some target or
another.  IMHO, it is still easiest to NFS root a 2.5 box than to worry
about IDE / SCSI being perfectly sane.  That said, IDE / SCSI have been
rather sane for a while now, so the chances are low of you kicking
yourself for not having done a backup recently..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
