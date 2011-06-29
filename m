Return-Path: <diggskevin38@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36129B6F5A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 04:09:34 +1000 (EST)
Received: by vws20 with SMTP id 20so1187389vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 11:09:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1309318110.32158.520.camel@pasglop>
References: <1308316207-9075-1-git-send-email-dbaryshkov@gmail.com>
	<1308316207-9075-2-git-send-email-dbaryshkov@gmail.com>
	<1309318110.32158.520.camel@pasglop>
Date: Wed, 29 Jun 2011 13:09:30 -0500
Message-ID: <BANLkTikD_x3QA8_q8+444QhA39SEW6hVfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add cpufreq driver for Momentum Maple boards
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	Dave Jones <davej@redhat.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Tue, Jun 28, 2011 at 10:28 PM, Benjamin Herrenschmidt >
>
> If we're going to have a Kconfig.powerpc, should we maybe just have a
> powerpc subdirectory instead with the driver in it ?
>
Where would the powerpc subdirectory be? under drivers/cpufreq? Or
somewhere under arch/powerpc where it belongs (and I put my 750GX
stuff)?

>
>> + =A0 =A0 printk(KERN_INFO "Frequency method: SCOM, Voltage method: none=
\n");
>
> This is useless.
>
Why?

> Cheers,
> Ben.
>
kevin
