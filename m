Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D741C1A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 02:32:34 +1000 (AEST)
Received: by pacyx8 with SMTP id yx8so63725246pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2015 09:32:32 -0700 (PDT)
Date: Mon, 8 Jun 2015 22:02:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [lockdep] cpufreq/ppc: possible circular locking dependency
 detected
Message-ID: <20150608163228.GD4198@linux>
References: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08-06-15, 18:45, Denis Kirjanov wrote:
> Hi,
> 
> I see the following lockdep splat on my RackMac machine on boot:

What kernel version is it ?

-- 
viresh
