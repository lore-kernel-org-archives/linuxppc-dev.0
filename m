To: "D'Abbraccio Joe-ljd015" <Joe.D'abbraccio@motorola.com>
Cc: "'Linuxppc-Embedded (E-mail)'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ELDK builds for 8260 ADS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 17 Oct 2002 18:11:53 EDT."
             <6D4DC8B4AD16D6118E8200D0B76FE262024188CD@ONT06EXM01>
Date: Fri, 18 Oct 2002 00:28:12 +0200
Message-Id: <20021017222818.0BDC9FAA8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Joe,

in message <6D4DC8B4AD16D6118E8200D0B76FE262024188CD@ONT06EXM01> you wrote:
> We are using the 1.0.1 of the ELDK.  The problem is as follows->
>
> In file included from /ads-root/usr/include/asm/io.h:38,
>                  from atm_hw.c:13:
> /ads-root/usr/include/asm/mpc8260.h:40: platforms/ads826x.h: No such file or directory
>
> mpc8260.h snip:
> >>>>>>>>>
> #ifdef CONFIG_WILLOW
> #include <platforms/willow.h>
> #endif

This is not the version of mpc8260.h that shipped with the ELDK.

> Is the fix to add a link as follows: usr/include/platforms -> ../src/linux/arch/ppc/platforms

If you use kernel sources which differ from those  shipped  with  the
ELDK you must make sure to adjust your include path as necessary.

Do NOT manipulate the contents of ppc_???/usr/include;  what's  there
now   matches   the  version  of  glibc  you  have  now.  Introducing
discrepancies might introduce unwanted effects.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Remember that Beethoven wrote his first symphony in C ...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
