Message-ID: <39AC0BF9.38DB6A9A@mvista.com>
Date: Tue, 29 Aug 2000 12:16:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
Reply-To: mgreer@mvista.com
MIME-Version: 1.0
To: Alex Shnitman <alexsh@hectic.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I downloaded the kernel and tried it. It starts booting, but it hangs

> right after initializing the the OpenPIC. :-( I'll download the source
> code tonight and try to look at it, although I don't have much hopes
> -- I've never done kernel hacking at that level. At some point you
> gotta learn though.
>
> Is there any book that you recommend to get me started? Any other
> docs/tips?

Oops, I should have included the sandpoint switch settings.  For this version of
the kernel, the sandpoint switches must be set as follows:

S4,S3: up, down
S5: down
S6: down (yours is probably up which is why it hung in openpic)

Try this and see if it helps.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
