Return-Path: <tmarri@apm.com>
Received: from exprod5og104.obsmtp.com (exprod5og104.obsmtp.com [64.18.0.178])
	by ozlabs.org (Postfix) with SMTP id 6AD80B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 12:09:18 +1000 (EST)
Received: by mail-qy0-f182.google.com with SMTP id 4so931064qyk.6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 08 Sep 2010 19:09:16 -0700 (PDT)
From: Tirumala Marri <tmarri@apm.com>
References: <a3a9eb5a2e770f931950ad13c01960da@mail.gmail.com>
	<20100909004853.GA11808@zod.rchland.ibm.com>
In-Reply-To: <20100909004853.GA11808@zod.rchland.ibm.com>
MIME-Version: 1.0
Date: Wed, 8 Sep 2010 19:09:16 -0700
Message-ID: <5769f3acee477be2178d5b3bbd0191d7@mail.gmail.com>
Subject: RE: Combining defconfigs for 44x based boards
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> Linus made a suggestion to that effect?  If so, I missed it.  Have a
> pointer?

There was discussion going on in arm-kernel mailing list. And I see some
patches being submitted for ARM based boards.
I think we can also combine some of the defconfigs under
arch/powerpc/configs/44x/ directory.

Here is ARM dfconfigs discussion
http://lkml.indiana.edu/hypermail/linux/kernel/1006.0/01464.html

Here is the link for some of the defconfig submissions
http://www.spinics.net/lists/arm-kernel/msg96972.html
