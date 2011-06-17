Return-Path: <davej@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id E78FEB6FD9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 06:07:51 +1000 (EST)
Date: Fri, 17 Jun 2011 16:07:40 -0400
From: Dave Jones <davej@redhat.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] Add cpufreq driver for Momentum Maple boards
Message-ID: <20110617200740.GA31457@redhat.com>
References: <1308284088.32158.0.camel@pasglop>
	<1308300556-4463-1-git-send-email-dbaryshkov@gmail.com>
	<201106171117.14794.arnd@arndb.de>
	<BANLkTimo6k=Zz+QnP0VaWYf3jDjpFXNL4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BANLkTimo6k=Zz+QnP0VaWYf3jDjpFXNL4w@mail.gmail.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, cpufreq@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 17, 2011 at 03:12:56PM +0400, Dmitry Eremin-Solenikov wrote:
 > What about drivers/cpufreq/powerpc, or it's an unnecessary?

We haven't done it so far for x86 & arm, so for now at least, just keeping
them in drivers/cpufreq/ should be sufficient.

 > Should I resumbit it, or there will be massive arch/powerpc ->
 > drivers/cpufreq move?

Good question. I haven't heard anything from any of the PPC maintainers
on this subject, but I'll be happy to help out where I can if they
decide to follow suit with x86/arm.

	Dave
