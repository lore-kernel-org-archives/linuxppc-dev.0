Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 46BEEB6FCF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Jun 2011 10:53:11 +1000 (EST)
Received: by pvf33 with SMTP id 33so524151pvf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 08 Jun 2011 17:53:09 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 8 Jun 2011 18:52:49 -0600
Message-ID: <BANLkTimDGd3YwGC__CaQDnHLXhAJ-CSHbA@mail.gmail.com>
Subject: [GIT PULL] trivial fix for .gitignore files in powerpc
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since commit 06e86849cf4019945a106913adb9ff0abcc01770:

  Merge branch 'pm-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6
(2011-06-08 15:58:51 -0700)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 powerpc/merge

Wolfram Sang (1):
      dtc/powerpc: remove obsolete .gitignore entries

 arch/powerpc/boot/.gitignore         |    1 -
 arch/powerpc/boot/dtc-src/.gitignore |    3 ---
 2 files changed, 0 insertions(+), 4 deletions(-)
 delete mode 100644 arch/powerpc/boot/dtc-src/.gitignore


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
