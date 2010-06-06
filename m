Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A5A52B7D69
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 01:40:58 +1000 (EST)
Date: Sun, 6 Jun 2010 16:40:48 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: 2.6.35-rc2 : OOPS with LTP memcg regression test run.
Message-ID: <20100606154048.GJ31073@ZenIV.linux.org.uk>
References: <4C0BB98E.9030101@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C0BB98E.9030101@in.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 06, 2010 at 08:36:54PM +0530, Sachin Sant wrote:

> And few more of these. Previous snapshot release 2.6.35-rc1-git5(6c5de280b6...)
> was good.

That's very odd, since
; git diff --stat 6c5de280b6..v2.6.35-rc2         
 Makefile                             |    2 +-
 drivers/gpu/drm/i915/intel_display.c |    9 +++++++
 fs/ext4/inode.c                      |   40 +++++++++++++++++++--------------
 fs/ext4/move_extent.c                |    3 ++
 4 files changed, 36 insertions(+), 18 deletions(-)
;
and nothing of that looks like good candidates...
