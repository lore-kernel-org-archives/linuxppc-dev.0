Return-Path: <vapier.adi@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 307A9B6F94
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 03:00:52 +1000 (EST)
Received: by fxm5 with SMTP id 5so224456fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jun 2011 10:00:48 -0700 (PDT)
MIME-Version: 1.0
Sender: vapier.adi@gmail.com
In-Reply-To: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
References: <1306945763-6583-1-git-send-email-wanlong.gao@gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 1 Jun 2011 13:00:28 -0400
Message-ID: <BANLkTinEc8OLHnkVCZVpHK4ZnC1DHbEsvw@mail.gmail.com>
Subject: Re: [PATCH] Fix build warning of the defconfigs
To: Wanlong Gao <wanlong.gao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com,
	linux-sh@vger.kernel.org, paulus@samba.org, gxt@mprc.pku.edu.cn,
	sam@ravnborg.org, linux@arm.linux.org.uk,
	manuel.lauss@googlemail.com, rientjes@google.com, mingo@elte.hu,
	arnd@arndb.de, u.kleine-koenig@pengutronix.de, anton@samba.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	lethal@linux-sh.org, uclinux-dist-devel@blackfin.uclinux.org,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	hans-christian.egtvedt@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 1, 2011 at 12:29, Wanlong Gao wrote:
> =C2=A0arch/blackfin/configs/CM-BF548_defconfig =C2=A0 | =C2=A0 =C2=A02 +-

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
