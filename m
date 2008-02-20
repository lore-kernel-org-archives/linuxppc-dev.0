Return-Path: <biggerbadderben@gmail.com>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.187])
	by ozlabs.org (Postfix) with ESMTP id 09DAEDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 02:49:31 +1100 (EST)
Received: by ti-out-0910.google.com with SMTP id y6so1234708tia.13
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 07:49:29 -0800 (PST)
Message-ID: <f8328f7c0802200749h7a761fffha636f292b54182e5@mail.gmail.com>
Date: Wed, 20 Feb 2008 10:49:27 -0500
From: "Ben Warren" <biggerbadderben@gmail.com>
To: "Kalle Pokki" <kalle.pokki@eke.fi>
Subject: Re: ELDK on 64-bit host
In-Reply-To: <a425f86c0802200703x6cbbd5acwa4b3a8dda455eeea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <a425f86c0802200703x6cbbd5acwa4b3a8dda455eeea@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 20, 2008 at 10:03 AM, Kalle Pokki <kalle.pokki@eke.fi> wrote:
> Hi,
>
>  I tried to copy the ELDK 4.0 installation I had to a new Core 2 Quad
>  machine running 64-bit Ubuntu 7.10, but the new machine refuses to
>  execute the cross compiler. Has anyone succeeded in running ELDK in
>  this kind of environment?
>
Yes (at least with 64-bit Debian on a single core Xeon), but you need
a special library on the host.  I think it's call 'ia32-libs'.  It
should be available via aptitude.

regards,
Ben
