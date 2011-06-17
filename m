Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 68C89B6FB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 21:13:03 +1000 (EST)
Received: by vws20 with SMTP id 20so958319vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 04:12:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201106171117.14794.arnd@arndb.de>
References: <1308284088.32158.0.camel@pasglop>
	<1308300556-4463-1-git-send-email-dbaryshkov@gmail.com>
	<201106171117.14794.arnd@arndb.de>
Date: Fri, 17 Jun 2011 15:12:56 +0400
Message-ID: <BANLkTimo6k=Zz+QnP0VaWYf3jDjpFXNL4w@mail.gmail.com>
Subject: Re: [PATCH] Add cpufreq driver for Momentum Maple boards
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: davej@redhat.com, linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On 6/17/11, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 17 June 2011 10:49:16 Dmitry Eremin-Solenikov wrote:
>> Add simple cpufreq driver for Maple-based boards (ppc970fx evaluation
>> kit and others). Driver is based on a cpufreq driver for 64-bit powermac
>> boxes with all pmac-dependant features removed and simple cleanup
>> applied.
>>
>> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
>> ---
>>  arch/powerpc/kernel/misc_64.S          |    4 +-
>>  arch/powerpc/platforms/Kconfig         |    8 +
>>  arch/powerpc/platforms/maple/Makefile  |    1 +
>>  arch/powerpc/platforms/maple/cpufreq.c |  317
>> ++++++++++++++++++++++++++++++++
>>  4 files changed, 328 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/powerpc/platforms/maple/cpufreq.c
>>
>
>
> I think new cpufreq drivers should live in drivers/cpufreq, not in arch/.
> We've
> started moving other drivers away from arch/x86 and arch/arm already.

What about drivers/cpufreq/powerpc, or it's an unnecessary?

Should I resumbit it, or there will be massive arch/powerpc ->
drivers/cpufreq move?

-- 
With best wishes
Dmitry
