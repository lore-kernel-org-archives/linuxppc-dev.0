Return-Path: <jwboyer@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 26E78B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 29 Jun 2009 10:23:08 +1000 (EST)
Received: from mail-px0-f182.google.com (mail-px0-f182.google.com
	[209.85.216.182]) by ozlabs.org (Postfix) with ESMTP id A26FFDDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 10:23:05 +1000 (EST)
Received: by pxi12 with SMTP id 12so3349368pxi.17
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 17:23:04 -0700 (PDT)
Date: Sun, 28 Jun 2009 20:14:47 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: Have Warp take advantage of GPIO LEDs
	default-state = keep
Message-ID: <20090629001447.GH4832@hansolo.jdub.homelinux.org>
References: <20090628172251.7bc0c8e0@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090628172251.7bc0c8e0@lappy.seanm.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 28, 2009 at 05:22:51PM -0400, Sean MacLennan wrote:
>Yes, it's me again. The GPIO LEDs default-state = keep patch was
>accepted into the kernel. This patch takes advantage of that patch. 

I haven't forgotten about your patches.  Will try and get them pulled together
and send them on to Ben tomorrow.

Thanks,
josh
