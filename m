Return-Path: <leon.woestenberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A4199B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Sep 2009 06:38:24 +1000 (EST)
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id D6C23DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Sep 2009 06:38:23 +1000 (EST)
Received: by fxm22 with SMTP id 22so2095715fxm.9
	for <linuxppc-dev@ozlabs.org>; Mon, 07 Sep 2009 13:38:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c384c5ea0909070401g30241826v89adda7aa0fb1d6d@mail.gmail.com>
References: <c384c5ea0909070401g30241826v89adda7aa0fb1d6d@mail.gmail.com>
Date: Mon, 7 Sep 2009 22:38:20 +0200
Message-ID: <c384c5ea0909071338p19f73545nddec9c0cfb2c5cf7@mail.gmail.com>
Subject: Re: MPC8536DS: u-boot detects PCIe card but Linux 2.6.30 does not.
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Linux PPC <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Mon, Sep 7, 2009 at 1:01 PM, Leon
Woestenberg<leon.woestenberg@gmail.com> wrote:
> on my MPC8536DS development board, a PCIe card does not get detected
> by Linux, u-boot does list it.
>
> I'm suspecting the PCIe bridge (?) to not initialize correctly, but
> that is a wild guess. See the u-boot log and kernel boot log with PCI
>

It seems this might be a endpoint hardware issue where the PCIe hot
reset signal is ignored.

Investigating further.

Regards,
-- 
Leon
