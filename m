Return-Path: <viresh.kumar@linaro.org>
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com
 [IPv6:2607:f8b0:4003:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91B9E2C00DB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 17:26:00 +1100 (EST)
Received: by mail-ob0-f173.google.com with SMTP id wn14so1228456obc.18
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2013 23:25:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1364985034.16520.12.camel@pasglop>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
 <4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
 <CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
 <CAKohpomRMkKouiy+iJUiheTcPGCDVLbxppL5f4oc-WMu2E5T8g@mail.gmail.com>
 <1364985034.16520.12.camel@pasglop>
Date: Thu, 4 Apr 2013 11:55:56 +0530
Message-ID: <CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
Subject: Re: [PATCH 9/9] powerpc: cpufreq: move cpufreq driver to
 drivers/cpufreq
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: robin.randhawa@arm.com, linux-pm@vger.kernel.org, Liviu.Dudau@arm.com,
 linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, Steve.Bannister@arm.com,
 Arnd Bergmann <arnd.bergmann@linaro.org>, arvind.chauhan@arm.com,
 linaro-kernel@lists.linaro.org, charles.garcia-tobin@arm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 3 April 2013 16:00, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> On Wed, 2013-04-03 at 15:00 +0530, Viresh Kumar wrote:
>> On 31 March 2013 09:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:

>> > Benjamin/Paul/Olof,
>> >
>> > Any comments on this?
>>
>> Ping!!
>
> I'm on vacation until end of April. No objection to the patch but
> somebody needs to test it.

Hi,

Can somebody else from powerpc world give it a try?

OR

@Rafael: Can we get this pushed in linux-next as is and then people would
be forced to test it and in case there are any complains, i will fix them or
you can revert it?
