Return-Path: <jvpeetz@web.de>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6jrX19JnzDqYk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 00:40:28 +1000 (AEST)
Subject: Re: Linux 4.7: Reported regressions as of Sunday, 2016-08-07
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <aecd3c94-e61a-946e-fb45-b5a4e1eb04db@leemhuis.info>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
From: =?UTF-8?Q?J=c3=b6rg-Volker_Peetz?= <jvpeetz@web.de>
Message-ID: <d49c111f-948e-eea0-932b-8f8eb231e134@web.de>
Date: Sun, 7 Aug 2016 16:30:39 +0200
MIME-Version: 1.0
In-Reply-To: <aecd3c94-e61a-946e-fb45-b5a4e1eb04db@leemhuis.info>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thorsten,

the ext4 problem reported here https://lkml.org/lkml/2016/8/5/150 an here
https://lkml.org/lkml/2016/8/3/262 seems to me to be a regression, partly,
because my laptop with 4.7.0 was also hit by it but I didn't dug into it.
There seems to be a remedy https://lkml.org/lkml/2016/8/5/367 but it's awaiting
confirmation.

Regards,
jvp.
