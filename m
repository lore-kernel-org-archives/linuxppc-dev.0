Return-Path: <linus.walleij@linaro.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B7D0B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 23:23:53 +1100 (EST)
Received: by iakh37 with SMTP id h37so7438413iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2012 04:23:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <C5C3845E-9732-4A9D-B1DC-84688E7D807F@kernel.crashing.org>
References: <1330424541-5299-1-git-send-email-martyn.welch@ge.com>
 <1330424541-5299-2-git-send-email-martyn.welch@ge.com>
 <C5C3845E-9732-4A9D-B1DC-84688E7D807F@kernel.crashing.org>
Date: Tue, 6 Mar 2012 13:23:50 +0100
Message-ID: <CACRpkdaTnu+Z49CDm1Ub1H9VK9WKMd48vwWmcmhn7YHWS9_HeQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] powerpc: Move GE GPIO and PIC drivers
From: Linus Walleij <linus.walleij@linaro.org>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linus.walleij@stericsson.com,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Martyn Welch <martyn.welch@ge.com>, Wim Van Sebroeck <wim@iguana.be>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 6, 2012 at 1:19 PM, Kumar Gala <galak@kernel.crashing.org> wrot=
e:
> On Feb 28, 2012, at 4:22 AM, Martyn Welch wrote:
>
>> Move the GE GPIO and PIC drivers to allow these to be used by non-86xx
>> boards.
>
> gpio driver should be in drivers/gpio. =A0Please split that move out as a=
 separate patch for Grant & Linus to review as part of the GPIO subsystem

Yes please. It will get a good home there, Grant knows everything about PPC=
...

Yours,
Linus Walleij
