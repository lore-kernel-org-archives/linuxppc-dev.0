Return-Path: <linus.walleij@linaro.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC7CBB7172
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 20:00:43 +1100 (EST)
Received: by wyi11 with SMTP id 11so4412765wyi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Feb 2011 01:00:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20110214.105553.296482686007701595.Hiroshi.DOYU@nokia.com>
References: <AANLkTikoExk30pqdcHXCA2K_oJB=VJ5_AnCkoYUrEt3X@mail.gmail.com>
	<20110214.093257.58795266617213863.Hiroshi.DOYU@nokia.com>
	<AANLkTimnHHhYKnvUgsMo_jsKaYdY+XuABZ+FV0p25JLi@mail.gmail.com>
	<20110214.105553.296482686007701595.Hiroshi.DOYU@nokia.com>
Date: Mon, 14 Feb 2011 10:00:38 +0100
Message-ID: <AANLkTikdNW1k9ym9kHbMxRTEmOfTsvCTYzKp8ypqrWG+@mail.gmail.com>
Subject: Re: [RFC] Inter-processor Mailboxes Drivers
From: Linus Walleij <linus.walleij@linaro.org>
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: meador_inge@mentor.com, Hollis_Blanchard@mentor.com, sunder.svit@gmail.com,
	openmcapi-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 14, 2011 at 9:55 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:

> Does db5500 use IOMMU for mapping shared memories?

Nope, it's a fixed physical allocation from the modem side
of the world.

Yours,
Linus Walleij
