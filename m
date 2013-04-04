Return-Path: <amit.kucheria@linaro.org>
Received: from mail-vc0-f180.google.com (mail-vc0-f180.google.com
 [209.85.220.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E03E2C00FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 17:30:46 +1100 (EST)
Received: by mail-vc0-f180.google.com with SMTP id m17so2066322vca.39
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Apr 2013 23:30:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
 <4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
 <CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
 <CAKohpomRMkKouiy+iJUiheTcPGCDVLbxppL5f4oc-WMu2E5T8g@mail.gmail.com>
 <1364985034.16520.12.camel@pasglop>
 <CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
Date: Thu, 4 Apr 2013 12:00:43 +0530
Message-ID: <CAP245DU68CCR9pDSryCv=tu00NjXkvEoerp6H6H9fQaYJgQA1g@mail.gmail.com>
Subject: Re: [PATCH 9/9] powerpc: cpufreq: move cpufreq driver to
 drivers/cpufreq
From: Amit Kucheria <amit.kucheria@linaro.org>
To: Viresh Kumar <viresh.kumar@linaro.org>, deepthi@linux.vnet.ibm.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Robin Randhawa <robin.randhawa@arm.com>, linux-pm@vger.kernel.org,
 Liviu Dudau <Liviu.Dudau@arm.com>, linux-kernel@vger.kernel.org,
 cpufreq@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
 Steve Bannister <Steve.Bannister@arm.com>, Paul Mackerras <paulus@samba.org>,
 Olof Johansson <olof@lixom.net>, Arvind Chauhan <arvind.chauhan@arm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
 Charles Garcia-Tobin <charles.garcia-tobin@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 4, 2013 at 11:55 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 3 April 2013 16:00, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> On Wed, 2013-04-03 at 15:00 +0530, Viresh Kumar wrote:
>>> On 31 March 2013 09:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>>> > Benjamin/Paul/Olof,
>>> >
>>> > Any comments on this?
>>>
>>> Ping!!
>>
>> I'm on vacation until end of April. No objection to the patch but
>> somebody needs to test it.
>
> Hi,
>
> Can somebody else from powerpc world give it a try?

Deepthi, can you help?

> OR
>
> @Rafael: Can we get this pushed in linux-next as is and then people would
> be forced to test it and in case there are any complains, i will fix them or
> you can revert it?
