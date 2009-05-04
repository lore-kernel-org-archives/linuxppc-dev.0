Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 49882DDDA0
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 21:55:40 +1000 (EST)
Date: Mon, 4 May 2009 13:57:04 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-kbuild <linux-kbuild@vger.kernel.org>
Subject: kbuild, modpost: fix "non-allocatable section" warnings
Message-ID: <20090504115704.GA7134@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Wolfgang Denk <wd@denx.de>,
	Manuel Lauss <mano@roarinelk.homelinux.net>,
	Anders Kaseorg <andersk@mit.edu>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sean MacLennan <smaclennan@pikatech.com>, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It turned out there were at least three sources of
the "non-allocatable section" warning.

1) SUSE specific .comment section
2) endianness issues in elf header
3) additional debug sections

I have updated kbuild-fixes.git with
patches for all of the above.

But as we have seen three independent sources of this
warning within short time I expect there may be
yet-to-be-discovered issues.

The patches accumulated so far all looks trivially correct
and Jean and Sean has been quick to test them.
So unless something unexpected shows up I plan to push them
within a day or two.

I would like to see them in -next for a day or two first
in the hope that if other architectures has troubles
they will report this before it hits upstream.

Patches will follow for reference / testing.

	Sam
