Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwSGP5yxyzDr13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 19:54:50 +1000 (AEST)
Date: Sun, 25 Jun 2017 10:53:58 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Regression in kernel 4.12-rc1 for Powerpc 32 - bisected to
 commit 3448890c32c3
Message-ID: <20170625095351.GU10672@ZenIV.linux.org.uk>
References: <20170621212257.GN10672@ZenIV.linux.org.uk>
 <5f4b9fa4-262a-31b1-32ba-a2f6e789b3d6@lwfinger.net>
 <20170621213415.GO10672@ZenIV.linux.org.uk>
 <655d304e-e455-6e0c-56e1-f127653ea13c@lwfinger.net>
 <20170622141203.GP10672@ZenIV.linux.org.uk>
 <7bbd4c87-e8ff-5f83-8c4c-e205872083bf@lwfinger.net>
 <20170622192515.GQ10672@ZenIV.linux.org.uk>
 <2346c306-8e26-94cb-3c63-b866a7f4625d@lwfinger.net>
 <20170623202943.GS10672@ZenIV.linux.org.uk>
 <3e093314-5148-2e14-33a9-e5d67bd2e7cf@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3e093314-5148-2e14-33a9-e5d67bd2e7cf@lwfinger.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 24, 2017 at 12:29:23PM -0500, Larry Finger wrote:

> I made a break through. If I turn off inline copy to/from users for 32-bit
> ppc with the following patch, then the system boots:

OK...  So it's 4.6.3 miscompiling something - it is hardware-independent,
reproduced in qemu.  I'd like to get more self-contained example of
miscompile, though; should be done by tonight...
