Return-Path: <geoff@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 966BD1007D8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2011 14:53:23 +1100 (EST)
Subject: RE: [PATCH v15 00/10] Add-Synopsys-DesignWare-HS-USB-OTG-driver
From: Geoff Levand <geoff@infradead.org>
To: Tirumala Marri <tmarri@apm.com>
In-Reply-To: <d4b201db8e7510eeeca77dc26dab02c1@mail.gmail.com>
References: <1318630114-14064-1-git-send-email-tmarri@apm.com>
 <20111021173302.GB27652@quad.lixom.net>
 <c898f5030d342baa4df570317536bcf2@mail.gmail.com>
 <CAOesGMhVuxbqq7cmm2XVUof9vEifAL=GpPirYb8148a24upJCw@mail.gmail.com>
 <d4b201db8e7510eeeca77dc26dab02c1@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 26 Oct 2011 20:52:55 -0700
Message-ID: <1319687575.3549.10.camel@pump>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, greg@kroah.com, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Marri,

On Wed, 2011-10-26 at 09:06 -0700, Tirumala Marri wrote:
> <
> <No, just start over from scratch. Just leave the crap driver behind,
> <use it for reference but write the new one.
> <
> <It's obvious given that you are already at iteration v15 and it's
> <still looking this bad that this is not realistic to get reviewed and
> <accepted as-is. I don't think staging is a good target either -- what
> <the driver really needs is _functional_ cut-down to only cover the use
> <cases that your product uses, and staging cleanups are mostly around
> <style and refactoring, not changing, fixing or removing functionality.
> <
> [Tirumala Marri] I like to hear What maintainer GregKH thinks. We already
> spent lot
> Of time on it and passed multiple hands.

I don't think the amount of time spent should be given much
consideration.  What matters is whether or not the code is acceptable.
Maybe you can do some coding on a whiteboard to get it right -- hahaha.

-Geoff
