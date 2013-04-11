Return-Path: <viresh.kumar@linaro.org>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BAEF22C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 17:02:54 +1000 (EST)
Received: by mail-oa0-f41.google.com with SMTP id f4so1266701oah.14
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 00:02:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130411065957.GB31465@quad.lixom.net>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
 <4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
 <CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
 <CAKohpomRMkKouiy+iJUiheTcPGCDVLbxppL5f4oc-WMu2E5T8g@mail.gmail.com>
 <1364985034.16520.12.camel@pasglop>
 <CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
 <20130411065957.GB31465@quad.lixom.net>
Date: Thu, 11 Apr 2013 12:32:50 +0530
Message-ID: <CAKohpomHFgMBAHax=jC_LNd8Gay9aWja+64An7QxnNpaPuuSQQ@mail.gmail.com>
Subject: Re: [PATCH 9/9] powerpc: cpufreq: move cpufreq driver to
 drivers/cpufreq
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: robin.randhawa@arm.com, linux-pm@vger.kernel.org, Liviu.Dudau@arm.com,
 linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Steve.Bannister@arm.com,
 Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd.bergmann@linaro.org>,
 arvind.chauhan@arm.com, linuxppc-dev@lists.ozlabs.org,
 linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11 April 2013 12:29, Olof Johansson <olof@lixom.net> wrote:
> That's not very nice this late in the staging cycle. Give the powerpc
> guys a little more time than a single day to come back with test results,
> please.

Yes we are waiting indefinitely for an Ack from powerpc guys.. If we can
get a Ack soon, we will get it in 3.10 otherwise next cycle.
