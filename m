Return-Path: <linus.walleij@linaro.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9C325B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 00:03:17 +1100 (EST)
Received: by ghbg19 with SMTP id g19so507618ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 06:03:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4F5F3E79.5030809@ge.com>
References: <1331572380-1064-1-git-send-email-martyn.welch@ge.com>
 <1331572380-1064-5-git-send-email-martyn.welch@ge.com>
 <CACRpkdZv84PKts4jFscsNcOq6rggZXSYzu3CBe8NFDTPwsd1aw@mail.gmail.com>
 <4F5F3E79.5030809@ge.com>
Date: Tue, 13 Mar 2012 14:03:15 +0100
Message-ID: <CACRpkdap9uNJw8nNOSzaFRcah=6Uc2EdNk=ErZHq9Ts4O4kKEw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] powerpc: Board support for GE IMP3A
From: Linus Walleij <linus.walleij@linaro.org>
To: Martyn Welch <martyn.welch@ge.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
 =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2012/3/13 Martyn Welch <martyn.welch@ge.com>:
> On 13/03/12 11:51, Linus Walleij wrote:

>> This habit of changing a lot of defconfig stuff in a patch dealing with other
>> stuff is alien in the ARM world. Especially when changing a horde of stuff
>> that has nothing to do with the patch subject.
>>
>
> This is adding the defconfig, it's support for a new board:

Ah I was confused by thinking the patch series was all about GPIO.
Sorry...

Yours,
Linus Walleij
