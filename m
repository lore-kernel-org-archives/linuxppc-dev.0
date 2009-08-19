Return-Path: <pku.leo@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5091EB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 13:19:48 +1000 (EST)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id A3232DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 13:19:47 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b6so1612371ana.39
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 20:19:45 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <20090818222335.GA28135@oksana.dev.rtsoft.ru>
References: <20090818222335.GA28135@oksana.dev.rtsoft.ru>
Date: Wed, 19 Aug 2009 11:19:45 +0800
Message-ID: <2a27d3730908182019w6d5c83b3k2efc542f6552b8b5@mail.gmail.com>
Subject: Re: [PATCH] USB: fsl_qe_udc: Add fsl,mpc8323-qe-usb compatible entry
From: Li Yang <leoli@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=UTF-8
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org,
	linux-usb@vger.kernel.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 19, 2009 at 6:23 AM, Anton
Vorontsov<avorontsov@ru.mvista.com> wrote:
> Current bindings specify that "fsl,mpc8323-qe-usb" compatible entry
> should be used as a base match for QE UDCs, so update the driver to
> comply with the bindings.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-by: Li Yang <leoli@freescale.com>

- Leo
