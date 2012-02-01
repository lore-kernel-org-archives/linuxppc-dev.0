Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2205FB6F98
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2012 17:29:42 +1100 (EST)
Date: Wed, 1 Feb 2012 14:42:21 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PULL] ARM mach/irqs.h cleanup for 3.4
Message-ID: <20120201054221.GA3531@linux-sh.org>
References: <4F284532.90303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F284532.90303@gmail.com>
Cc: Aurelien Jacquiot <a-jacquiot@ti.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, jamie@jamieiles.com,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-c6x-dev@linux-c6x.org,
 linux-sh@vger.kernel.org, Haojian Zhuang <haojian.zhuang@marvell.com>,
 Marek Vasut <marek.vasut@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>,
 Nicolas Pitre <nico@fluxnic.net>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2012 at 01:46:58PM -0600, Rob Herring wrote:
> Can you please pull mach/irqs.h clean-up for 3.4. I've gotten little to
> no response from the affected platform maintainers. It's primarily
> superh and shmobile that have any significant changes though.
> 
Sorry about that, it's been in my backlog. The changes as they are are
fine with me, I've got some pending work that switches to dynamic use off
of nr_irqs that will make most of it redundant that I had hoped to have
done in time, but it can be done incrementally at a later point in time,
too.
