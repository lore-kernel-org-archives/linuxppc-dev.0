Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0222.hostedemail.com
 [216.40.44.222])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qln3C5hNXzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 13:58:47 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 367751725F7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 03:51:50 +0000 (UTC)
Date: Wed, 13 Apr 2016 23:51:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kbuild test
 robot <lkp@intel.com>, Ingo Molnar <mingo@redhat.com>, kbuild-all@01.org
Subject: Re: [PATCH] ftrace: filter: Match dot symbols when searching
 functions on ppc64.
Message-ID: <20160413235142.26f64db8@grimm.local.home>
In-Reply-To: <2596502.8PPJLykyZv@hactar>
References: <201604020331.kEOeyhX0%fengguang.wu@intel.com>
 <3507082.VaWR3lh7Ni@hactar> <2596502.8PPJLykyZv@hactar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Apr 2016 21:39 -0300
Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:


> People seem to be considering patches for next, so this looks like a good=
=20
> moment to ping about this one.

Your timing is fine with respect to the merge window. I'm currently
traveling, but I'll get to it on Monday. I have it marked as TODO.

>=20
> Ps: patchwork seems to have an issue which causes it to show the message=
=20
> body as if it were the commit message, but if you feed my original email=
=20
> (the one I=E2=80=99m replying to here) to git am, the commit message will=
 be=20
> correct.
>=20

Yeah I noticed that. But I'll be able to handle it.

Thanks,

-- Steve
