Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0CC30B6F5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 06:58:48 +1000 (EST)
Received: by vws20 with SMTP id 20so1308718vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 13:58:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTikD_x3QA8_q8+444QhA39SEW6hVfg@mail.gmail.com>
References: <1308316207-9075-1-git-send-email-dbaryshkov@gmail.com>
	<1308316207-9075-2-git-send-email-dbaryshkov@gmail.com>
	<1309318110.32158.520.camel@pasglop>
	<BANLkTikD_x3QA8_q8+444QhA39SEW6hVfg@mail.gmail.com>
Date: Thu, 30 Jun 2011 00:58:44 +0400
Message-ID: <BANLkTimjBfMBXEdH7k-6sTjb1P+Fq3-Fvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add cpufreq driver for Momentum Maple boards
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: kevin diggs <diggskevin38@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	cpufreq@vger.kernel.org, Dave Jones <davej@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 29, 2011 at 10:09 PM, kevin diggs <diggskevin38@gmail.com> wrote:
> Hi,
>
> On Tue, Jun 28, 2011 at 10:28 PM, Benjamin Herrenschmidt >
>>
>> If we're going to have a Kconfig.powerpc, should we maybe just have a
>> powerpc subdirectory instead with the driver in it ?
>>
> Where would the powerpc subdirectory be? under drivers/cpufreq? Or
> somewhere under arch/powerpc where it belongs (and I put my 750GX
> stuff)?

drivers/cpufreq/powerpc. However my current version (as suggested by Ben)
goes directly to drivers/cpufreq

-- 
With best wishes
Dmitry
