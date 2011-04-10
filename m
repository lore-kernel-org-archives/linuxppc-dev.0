Return-Path: <wanlong.gao@gmail.com>
Received: from mail-pw0-f67.google.com (mail-pw0-f67.google.com
	[209.85.160.67]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 972C2B6F00
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Apr 2011 09:34:57 +1000 (EST)
Received: by pwi6 with SMTP id 6so763051pwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 10 Apr 2011 16:34:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110410181238.GE18601@pengutronix.de>
References: <1302375858-11253-1-git-send-email-wanlong.gao@gmail.com>
	<20110410181238.GE18601@pengutronix.de>
Date: Mon, 11 Apr 2011 07:34:53 +0800
Message-ID: <BANLkTima9-xmm2r6KeQcksvwhk5Wv4oaMA@mail.gmail.com>
Subject: Re: [PATCH] fix build warnings on defconfigs
From: wanlong gao <wanlong.gao@gmail.com>
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-mips@linux-mips.org, david.woodhouse@intel.com, tony@atomide.com,
	nicolas.ferre@atmel.com, paulus@samba.org, eric@eukrea.com,
	sam@ravnborg.org, sfr@canb.auug.org.au, linux@arm.linux.org.uk,
	khilman@deeprootsystems.com, manuel.lauss@googlemail.com,
	rientjes@google.com, mingo@elte.hu, anton@samba.org,
	ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	santosh.shilimkar@ti.com, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org, hans-christian.egtvedt@atmel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/11/11, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> On Sun, Apr 10, 2011 at 03:04:18AM +0800, wanlong.gao@gmail.com wrote:
>> From: Wanlong Gao <wanlong.gao@gmail.com>
>>
>> Change the BT_L2CAP and BT_SCO defconfigs from 'm' to 'y',
>> since BT_L2CAP and BT_SCO had changed to bool configs.
> Pointing out the commit that changed these two in the commit log would
> be nice. Something like:
>
> 	The BT_L2CAP and BT_SCO configs are bool since
>
> 		6427451 (Bluetooth: Merge L2CAP and SCO modules into bluetooth.ko)
>
> 	. So change all defconfigs from =3Dm to =3Dy.
>
> Other than that
> Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Thanks .
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
>
