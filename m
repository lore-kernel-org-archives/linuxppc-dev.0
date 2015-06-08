Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB95A1A03E5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2015 02:40:52 +1000 (AEST)
Received: by pdjn11 with SMTP id n11so70614344pdj.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2015 09:40:51 -0700 (PDT)
Date: Mon, 8 Jun 2015 22:10:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [lockdep] cpufreq/ppc: possible circular locking dependency
 detected
Message-ID: <20150608164047.GF4198@linux>
References: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
 <20150608163228.GD4198@linux>
 <CAOJe8K0rnDiYE3NHTcwgkxBYb5kxQZVAJreeXFL9yPpXVhNGqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K0rnDiYE3NHTcwgkxBYb5kxQZVAJreeXFL9yPpXVhNGqw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08-06-15, 19:37, Denis Kirjanov wrote:
> [    6.091149] 4.1.0-rc6-01265-g908e80d-dirty #15 Not tainted

Sorry, this points to a dirty tree. Can you please explain what's more
than rc6 is here ? Are you using any other patches from somewhere? 

-- 
viresh
