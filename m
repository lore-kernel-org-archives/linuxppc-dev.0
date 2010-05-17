Return-Path: <vapier.adi@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 04CF2B7DAD
	for <linuxppc-dev@ozlabs.org>; Mon, 17 May 2010 15:13:48 +1000 (EST)
Received: by gyf2 with SMTP id 2so1951767gyf.15
	for <linuxppc-dev@ozlabs.org>; Sun, 16 May 2010 22:13:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100512144017.GA722@faui48a.informatik.uni-erlangen.de>
References: <20100512143445.GA32559@faui48a.informatik.uni-erlangen.de>
	<20100512144017.GA722@faui48a.informatik.uni-erlangen.de>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Mon, 17 May 2010 01:13:23 -0400
Message-ID: <AANLkTinCRYpqKuJ8NM2sk2hvrgFiqvo9mvXLApun0myA@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] Config Items appearing twice in same Kconfig
	file?
To: Christoph Egger <siccegge@cs.fau.de>
Content-Type: text/plain; charset=UTF-8
Cc: linux-ia64@vger.kernel.org, vamos@i4.informatik.uni-erlangen.de,
	Jesse Barnes <jbarnes@virtuousgeek.org>, Timo Teras <timo.teras@iki.fi>,
	Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Lennox Wu <lennox.wu@gmail.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	"Pekka Savola \(ipv6\)" <pekkas@netcore.fi>, x86@kernel.org,
	James Morris <jmorris@namei.org>, Ingo Molnar <mingo@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Matt Turner <mattst88@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Mike Frysinger <vapier@gentoo.org>,
	Arnd Bergmann <arnd@arndb.de>, Graf Yang <graf.yang@analog.com>,
	Mikael Starvik <starvik@axis.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Richard Henderson <rth@twiddle.net>, Karsten Keil <isdn@linux-pingi.de>,
	Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
	linuxppc-dev@ozlabs.org, Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Patrick McHardy <kaber@trash.net>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linux-alpha@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 12, 2010 at 10:40, Christoph Egger wrote:
> =C2=A0 =C2=A0 =C2=A02 arch/blackfin/Kconfig:config MEM_MT48LC32M8A2_75

thanks, i'll get this simple bug fixed
-mike
