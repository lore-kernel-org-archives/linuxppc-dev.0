Message-ID: <20040523020029.65329.qmail@web15212.mail.bjs.yahoo.com>
Date: Sun, 23 May 2004 10:00:29 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: Module Compiling Problem
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040522072520.67684.qmail@web15206.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Song Sam <samlinuxppc@yahoo.com.cn> wrote

> A error happened when I compiled a module.Could any warmhearted person
> figure it out for me?

OK,I did it by myself.:-)
It turned out to be the fact that I enabled
CONFIG_MODVERSIONS=y in kernel configuration
and MODVERSIONS option in my module like
#if defined(CONFIG_MODVERSIONS)
#define MODVERSIONS
#include <linux/modversions.h>
#endif
at the same time.They conflicted against each other.Is
that so?A newbie error on module...

Best regards,

Sam

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
