Date: Wed, 2 Aug 2000 13:04:18 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Dan Malek <dan@netx4.com>, linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_PPC != Mac
In-Reply-To: <Pine.LNX.4.10.10008021351010.427-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10008021300280.11496-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2 Aug 2000, Geert Uytterhoeven wrote:

> Note that there was a time when we did have separate CONFIG_PMAC, CONFIG_PREP
> and CONFIG_CHRP switches. I liked it, since it allowed to customize your kernel
> more precisely.

Also note that one can use the __pmac __prep attributes which were added
to the kernel a long time ago, and __chrp which I recently added.  Granted
these wont 'weed out' code like cpp does but you can still get rid of
excess kernel data upon boot.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
