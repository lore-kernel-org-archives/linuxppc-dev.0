Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 1795EDDE9E
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:53:51 +1000 (EST)
Date: Wed, 2 May 2007 16:53:49 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Subject: Re: [patch 0/8] PS3 AV/FB patches
In-Reply-To: <200705021603.34637.rene@exactcode.de>
Message-ID: <Pine.LNX.4.62.0705021650290.3706@pademelon.sonytel.be>
References: <20070502124830.911142000@pademelon.sonytel.be>
	<200705021603.34637.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1494114468-1178117629=:3706"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1494114468-1178117629=:3706
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi René,

On Wed, 2 May 2007, [iso-8859-1] René Rebe wrote:
> While 3d acceleration is not that important for me on the PS3, just specifing
> a exact resolution, to e.g. drive non-TV display, does also not appear to be
> possible with the current ps3fb code and the hypervisor, only TV resolutions
> are support, right?

In addition to the TV resolutions 480i/480p/720p/1080i/1080p in 50/60 Hz,
ps3fb supports 1280x768 (WXGA), 1280x1024 (SXGA), and 1920x1200 (WUXGA).

> Is there any chance we can get at least modesetting and basic 2D acceleration
> (best some alpha-bitblt & colorspace conversion + scaling)?

These requests are definitely considered.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
---584337861-1494114468-1178117629=:3706--
