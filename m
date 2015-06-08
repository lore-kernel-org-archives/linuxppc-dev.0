Return-Path: <kda@linux-powerpc.org>
Received: from mail-yh0-f45.google.com (mail-yh0-f45.google.com
 [209.85.213.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411F51A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 02:37:45 +1000 (AEST)
Received: by yhid80 with SMTP id d80so32698566yhi.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2015 09:37:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150608163228.GD4198@linux>
References: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
 <20150608163228.GD4198@linux>
Date: Mon, 8 Jun 2015 19:37:43 +0300
Message-ID: <CAOJe8K0rnDiYE3NHTcwgkxBYb5kxQZVAJreeXFL9yPpXVhNGqw@mail.gmail.com>
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
> On 08-06-15, 18:45, Denis Kirjanov wrote:
>> Hi,
>>
>> I see the following lockdep splat on my RackMac machine on boot:
>
> What kernel version is it ?
[    6.091149] 4.1.0-rc6-01265-g908e80d-dirty #15 Not tainted
> --
> viresh
>
