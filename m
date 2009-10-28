Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E38111007DE
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Oct 2009 08:44:56 +1100 (EST)
Date: Wed, 28 Oct 2009 13:11:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/7] bitmap: Introduce bitmap_set, bitmap_clear,
	bitmap_find_next_zero_area
Message-Id: <20091028131141.523854cb.akpm@linux-foundation.org>
In-Reply-To: <1256719397-4258-1-git-send-email-akinobu.mita@gmail.com>
References: <1256719397-4258-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-usb@vger.kernel.org, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
	Lothar Wassmann <LW@KARO-electronics.de>, x86@kernel.org,
	linux-altix@sgi.com, Ingo Molnar <mingo@redhat.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>,
	Yevgeny Petrilin <yevgenyp@mellanox.co.il>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Why were these patches resent?  What changed?

Everybody who is going to review these patches has already reviewed
them and now they need to review them all again?
