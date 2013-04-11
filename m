Return-Path: <olof@lixom.net>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C463A2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 16:59:59 +1000 (EST)
Received: by mail-pd0-f169.google.com with SMTP id 10so704383pdc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 23:59:57 -0700 (PDT)
Date: Wed, 10 Apr 2013 23:59:57 -0700
From: Olof Johansson <olof@lixom.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 9/9] powerpc: cpufreq: move cpufreq driver to
 drivers/cpufreq
Message-ID: <20130411065957.GB31465@quad.lixom.net>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
 <4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
 <CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
 <CAKohpomRMkKouiy+iJUiheTcPGCDVLbxppL5f4oc-WMu2E5T8g@mail.gmail.com>
 <1364985034.16520.12.camel@pasglop>
 <CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKohpo=EPbGocbNaZcNtGuZy4Tst5jH4rPviQ6L=YuZceDnKMw@mail.gmail.com>
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

On Thu, Apr 04, 2013 at 11:55:56AM +0530, Viresh Kumar wrote:
> On 3 April 2013 16:00, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > On Wed, 2013-04-03 at 15:00 +0530, Viresh Kumar wrote:
> >> On 31 March 2013 09:33, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> >> > Benjamin/Paul/Olof,
> >> >
> >> > Any comments on this?
> >>
> >> Ping!!
> >
> > I'm on vacation until end of April. No objection to the patch but
> > somebody needs to test it.
> 
> Hi,
> 
> Can somebody else from powerpc world give it a try?
> 
> OR
> 
> @Rafael: Can we get this pushed in linux-next as is and then people would
> be forced to test it and in case there are any complains, i will fix them or
> you can revert it?


That's not very nice this late in the staging cycle. Give the powerpc
guys a little more time than a single day to come back with test results,
please.


-Olof
