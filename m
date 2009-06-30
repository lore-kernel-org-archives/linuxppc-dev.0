Return-Path: <jonsmirl@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 167D3B7096
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 10:26:16 +1000 (EST)
Received: from mail-qy0-f188.google.com (mail-qy0-f188.google.com
	[209.85.221.188]) by ozlabs.org (Postfix) with ESMTP id 71294DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 10:26:15 +1000 (EST)
Received: by qyk26 with SMTP id 26so2351527qyk.17
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 17:26:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090629234214.12670.9082.stgit@localhost.localdomain>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
Date: Mon, 29 Jun 2009 20:26:12 -0400
Message-ID: <9e4733910906291726h5cd5bdf8ve7e946aef855ac07@mail.gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 29, 2009 at 7:42 PM, Grant Likely<grant.likely@secretlab.ca> wr=
ote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> AC97 bus register read/write hooks need to provide locking, but the
> mpc5200-psc-ac97 driver does not. =A0This patch adds a mutex around
> the register access routines.

Does your touchscreen driver use this mutex? Or was this mutex needed
just for the AC97 driver?


--=20
Jon Smirl
jonsmirl@gmail.com
