Date: Mon, 18 Nov 2002 12:46:52 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: joakim.tjernlund@lumentis.se, mds@paradyne.com,
	linuxppc-embedded@lists.linuxppc.org, sensors@Stimpy.netroedge.com
Subject: Re: 8xx i2c refers to unspecified chip errata
Message-ID: <20021118194651.GE18374@opus.bloom.county>
References: <3DD939B5.3D1F2B6E@paradyne.com> <IGEFJKJNHJDCBKALBJLLIEBKFIAA.joakim.tjernlund@lumentis.se> <20021118204248.0a3b6bda.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021118204248.0a3b6bda.khali@linux-fr.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Nov 18, 2002 at 08:42:48PM +0100, Jean Delvare wrote:
>
> > Patch was(and still is, I think) against linuxppc_2_4_devel. Don't
> > know your tree, is it not the same as linuxppc? Anyhow, too much time
> > has passed for me to remember all details and I don't have the time to
> > go back and do it all over again. I suggest you take the linuxppc
> > version, patch it and adopt it to your tree.
>
> Why the hell are there two different trees? :'( Can't we work all
> together for a better result?

Because the linuxppc tree doesn't track the whole i2c tree, as that would
be quite silly. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
