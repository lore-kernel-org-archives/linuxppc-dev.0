Return-Path: <glikely@secretlab.ca>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F0C4B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 08:30:07 +1000 (EST)
Received: by pbcwy12 with SMTP id wy12so5710016pbc.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2012 15:30:05 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Get rid of PowerPC users of NR_IRQS
Date: Mon, 23 Apr 2012 16:30:00 -0600
Message-Id: <1335220202-32533-1-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Here's the 2nd version of the NR_IRQS cleanup patches for PowerPC.  I've
addressed your comments and compile tested them, but I've not tried to
boot.  If they check out for you then they should probably go into v3.4.

g.
