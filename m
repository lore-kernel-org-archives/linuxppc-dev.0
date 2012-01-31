Return-Path: <diggskevin38@gmail.com>
Received: from mail-pw0-f42.google.com (mail-pw0-f42.google.com
 [209.85.160.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E0E3B6EF7
 for <linuxppc-dev@ozlabs.org>; Wed,  1 Feb 2012 06:31:19 +1100 (EST)
Received: by pbdv2 with SMTP id v2so418314pbd.15
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2012 11:31:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <m2obtmhpx4.fsf@linux-m68k.org>
References: <CAKTLLVQTt8aRFb2QpXkUUikTJshnV_ytTWJ778MZ1ACyoD8aOw__43210.997261531$1327806577$gmane$org@mail.gmail.com>
 <m2obtmhpx4.fsf@linux-m68k.org>
Date: Tue, 31 Jan 2012 13:31:17 -0600
Message-ID: <CAKTLLVRkeVuJaM9w4o8rNCtR9jeWrvd-rYgyvpTv+uOr54zG6Q@mail.gmail.com>
Subject: Re: RTC on 2.6.36 for PowerMac 8600
From: kevin diggs <diggskevin38@gmail.com>
To: Andreas Schwab <schwab@linux-m68k.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 1/29/12, Andreas Schwab <schwab@linux-m68k.org> wrote:
> kevin diggs <diggskevin38@gmail.com> writes:
>
>
> Perhaps the RTC was reset due to battery running out?  That would set
> the year to 1900, but the kernel RTC interface cannot represent dates
> before 1970.  Unfortunately hwclock insists on reading the RTC even when
> you just want to write to it, so you cannot fix that with hwclock -w.
> When the battery of my iBook has run out I'm using the following to
> reset RTC to current time so that it is usable again.
>
> Andreas.
>
>
Thanks! I did not know about this problem with the year. This vintage
of mac sets the year to 1956.

Yes, the battery is dead. It is one of those $20 1/3 AA lithium cells.
I can't afford to replace it. I went into the MacOS Classic date
control panel and set the year to 1971 and it worked!

Thanks for the tip. I would have never figured this one out!

kevin
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
>
