Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wywnr413JzDr4V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 20:27:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eryu Guan <eguan@redhat.com>, linuxppc-dev@lists.ozlabs.org
Cc: liwan@redhat.com
Subject: Re: [v4.12-rc1 regression] mount ext4 fs results in kernel crash on
 PPC64le host
In-Reply-To: <20170628083237.GF23360@eguan.usersys.redhat.com>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
Date: Thu, 29 Jun 2017 20:27:11 +1000
Message-ID: <87h8yz9ji8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Eryu Guan <eguan@redhat.com> writes:

> Hi all,
>
> Li Wang and I are constantly seeing ppc64le hosts crashing due to bad
> page access. But it's not reproducing on every ppc64le host we've
> tested, but it usually happened in filesystem testings.

<snip>

> And I've confirmed that reverting above commit 'resolves' the crash.

Do you mean ~v4.12-rc7 with that commit reverted still triggers the
crash?

cheers
