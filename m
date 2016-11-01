Return-Path: <pebolle@tiscali.nl>
Received: from lb1-smtp-cloud6.xs4all.net (lb1-smtp-cloud6.xs4all.net
 [194.109.24.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7PSb3RV0zDvNV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 19:25:51 +1100 (AEDT)
Message-ID: <1477988293.2230.36.camel@tiscali.nl>
Subject: Re: Linux 4.9: Reported regressions as of Sunday, 2016-10-30
From: Paul Bolle <pebolle@tiscali.nl>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Jonathan Corbet <corbet@lwn.net>
Date: Tue, 01 Nov 2016 09:18:13 +0100
In-Reply-To: <0eb29167-7908-e049-6927-d9c6b093970d@leemhuis.info>
References: <0eb29167-7908-e049-6927-d9c6b093970d@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-10-30 at 14:20 +0100, Thorsten Leemhuis wrote:
> As always: Are you aware of any other regressions? Then please let me
> know (simply CC regressions@leemhuis.info).

Do build regressions count?

Because I was trying to fix an obscure build issue in arch/mips, choose
a random configuration that should hit that issue, and promptly ran
into
https://lkml.kernel.org/r/<201610301405.K82KqqW0%25fengguang.wu@intel.com>
The same configuration does build under v4.8, I tested that of course.

(Side note: I had to manually insert "25" after "%" to get this to
work. Should Intel fix its mail setup, or should lkml.kernel.org learn
to escape "%"?)

Thanks,


Paul Bolle
