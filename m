Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f174.google.com (mail-yk0-f174.google.com
 [209.85.160.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A12F31A05E3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 02:43:25 +1000 (AEST)
Received: by ykfr66 with SMTP id r66so54642478ykf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2015 09:43:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150608164047.GF4198@linux>
References: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
 <20150608163228.GD4198@linux>
 <CAOJe8K0rnDiYE3NHTcwgkxBYb5kxQZVAJreeXFL9yPpXVhNGqw@mail.gmail.com>
 <20150608164047.GF4198@linux>
Date: Mon, 8 Jun 2015 19:43:23 +0300
Message-ID: <CAOJe8K13bdNUZuz8abboX2WS01Rk-hvV=KrV0=JW_6KSzxESZA@mail.gmail.com>
Subject: Re: [lockdep] cpufreq/ppc: possible circular locking dependency
 detected
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/8/15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-06-15, 19:37, Denis Kirjanov wrote:
>> [    6.091149] 4.1.0-rc6-01265-g908e80d-dirty #15 Not tainted
>
> Sorry, this points to a dirty tree. Can you please explain what's more
> than rc6 is here ? Are you using any other patches from somewhere?

Ah, forgot to mention: I'm trying to fix the issue with the kmemleak so I've
added debuginfo to the drivers/char/agp/uninorth-agp.c. Nothing special.
>
> --
> viresh
>
