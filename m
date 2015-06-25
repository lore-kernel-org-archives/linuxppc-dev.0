Return-Path: <rjwysocki@gmail.com>
Received: from mail-wi0-x22f.google.com (mail-wi0-x22f.google.com
 [IPv6:2a00:1450:400c:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F37F61A05F3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 10:06:36 +1000 (AEST)
Received: by wiga1 with SMTP id a1so149499511wig.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 17:06:32 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1435183570.3790.15.camel@kernel.crashing.org>
References: <20150624064801.30680.3246.stgit@perfhull-ltc.austin.ibm.com>
 <1700583.a34yOllUuC@vostro.rjw.lan>
 <1435183570.3790.15.camel@kernel.crashing.org>
Date: Thu, 25 Jun 2015 02:06:32 +0200
Message-ID: <CAJZ5v0hiKVN7Nvc4w3BP9uWmvdUkX6T+DUGh6OSZWPTrpwcyjA@mail.gmail.com>
Subject: Re: [PATCH] tick/idle/powerpc: Do not register idle states with
 CPUIDLE_FLAG_TIMER_STOP set in periodic mode
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, mpe@ellerman.id.au,
 Will Deacon <will.deacon@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 shreyas@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 25, 2015 at 12:06 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2015-06-24 at 15:50 +0200, Rafael J. Wysocki wrote:
>> 4.2 material I suppose?
>
> And stable. Without this, if you configure without TICK_ONESHOT, the
> machine will hang.

OK, which -stable?  All of them or any specific series?

Rafael
