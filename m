Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 497E0B7043
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Nov 2010 07:52:40 +1100 (EST)
Subject: Re: RFC: Mega rename of device tree routines from of_*() to dt_*()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
References: <1290607413.12457.44.camel@concordia>
	<1290692075.689.20.camel@concordia>
	<AANLkTim9fPPWO-240dmavng+j=70G8Y4P-+j3Y+OZTL0@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Nov 2010 07:52:04 +1100
Message-ID: <1290718324.32570.127.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch <linux-arch@vger.kernel.org>,
	linux-mips <linux-mips@linux-mips.org>, microblaze-uclinux@itee.uq.edu.au,
	devicetree-discuss@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-11-25 at 15:01 +0100, Geert Uytterhoeven wrote:
> 
> I always read it as "for each child-OF-node", so I would rename it to
> "dt_for_each_child_node".

Well, it was meant to be for_child_of_node not _OF_node :-)

Cheers,
Ben.
