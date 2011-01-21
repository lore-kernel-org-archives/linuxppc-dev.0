Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
	[209.85.210.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C58AEB70DA
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2011 16:42:21 +1100 (EST)
Received: by iym14 with SMTP id 14so1958805iym.15
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Jan 2011 21:42:18 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 20 Jan 2011 22:41:58 -0700
Message-ID: <AANLkTinuAQb_OyfoA-8ivgC7MnQYfiMai2wQKjtOj_-K@mail.gmail.com>
Subject: [git pull] devicetree build failure fix
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus,

Here's a fix for a stupid bug I introduced.

g.

The following changes since commit c56eb8fb6dccb83d9fe62fd4dc00c834de9bc470:

  Linux 2.6.38-rc1 (2011-01-18 15:14:02 -0800)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 devicetree/merge

Grant Likely (1):
      powerpc/83xx: fix build failures on dt compatible list.

 arch/powerpc/platforms/83xx/mpc830x_rdb.c |    4 ++--
 arch/powerpc/platforms/83xx/mpc831x_rdb.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
