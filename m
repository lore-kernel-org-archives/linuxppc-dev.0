Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 73461B6FA3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 21:53:10 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Dmitry Eremin-Solenikov" <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Add cpufreq driver for Momentum Maple boards
Date: Fri, 17 Jun 2011 13:52:37 +0200
References: <1308284088.32158.0.camel@pasglop>
	<201106171117.14794.arnd@arndb.de>
	<BANLkTimo6k=Zz+QnP0VaWYf3jDjpFXNL4w@mail.gmail.com>
In-Reply-To: <BANLkTimo6k=Zz+QnP0VaWYf3jDjpFXNL4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106171352.38707.arnd@arndb.de>
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

On Friday 17 June 2011 13:12:56 Dmitry Eremin-Solenikov wrote:
> > I think new cpufreq drivers should live in drivers/cpufreq, not in arch/.
> > We've
> > started moving other drivers away from arch/x86 and arch/arm already.
> 
> What about drivers/cpufreq/powerpc, or it's an unnecessary?

drivers/cpufreq is fine by itself, unless Dave has some preference.

> Should I resumbit it, or there will be massive arch/powerpc ->
> drivers/cpufreq move?

My recommendation would be to submit the new driver for drivers/cpufreq
directly and let Ben take care of the others at a convenient time.

	Arnd
