Return-Path: <dedekind1@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A58FB6F67
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 00:51:36 +1000 (EST)
Received: by gwb17 with SMTP id 17so3086146gwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Aug 2011 07:51:33 -0700 (PDT)
Subject: Re: [PATCH v3] mtd: eLBC NAND: update ecc_stats.corrected when
	lteccr available
From: Artem Bityutskiy <dedekind1@gmail.com>
To: MichaelHench@gmail.com
Date: Mon, 15 Aug 2011 17:53:11 +0300
In-Reply-To: <CAHyXW61rWcoE0Wcd9K7BsP3+VKzmQo=RPMM9+1DTw+QdF9MVew@mail.gmail.com>
References: <CAHyXW61rWcoE0Wcd9K7BsP3+VKzmQo=RPMM9+1DTw+QdF9MVew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313419997.2600.8.camel@sauron>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, mlcreech@gmail.com, mhench@elutions.com
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-07-26 at 15:07 -0500, Michael Hench wrote:
> update ecc_stats.corrected if LTECCR register is available.
> 
> v2: kernel standard C formatting
> 
> v3: kernel standard C formatting again, changed a comment to get under 80 chars
> 
> Signed-off-by: Michael Hench <MichaelHench@gmail.com>

Pushed to l2-mtd-2.6.git, thanks.

-- 
Best Regards,
Artem Bityutskiy
