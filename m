To: Eli Brin <elib@rokonet.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Access u-boot environment variables from Linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 14 Jul 2003 12:18:17 +0200."
             <75DF04AC5ED4D511A9810090273CB4163F5DE2@rokonet-e.rokonet.co.il>
Date: Mon, 14 Jul 2003 12:13:39 +0200
Message-Id: <20030714101344.67427C6D82@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Eli,

in message <75DF04AC5ED4D511A9810090273CB4163F5DE2@rokonet-e.rokonet.co.il> you wrote:
>
> >Hardware Information Block which can be installed at offset
> >0x0003FFC0 in the first flash bank?
>
> Yes, but our final target will use 0x0003FF00, so we can have more
> space. We are making our target as compatible as possible to the
> TQM860L.

Well, if you move the address, you're breaking compatibility  anyway.
Feel free to implement a proprietary solution that fits your needs.

> Perhaps, and probably, you are right. I will re-check/re-think. It
> looks easier to make changes on the SELF scripts. And it can be used
> on Linux version that do not support the ELDK rebuild from scratch.

Agreed.

> Anyway, my original problem is solved :) . I use the /tools/env, and
> perhaps later the MTD patch.

Fine.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In C we had to code our own bugs, in C++ we can inherit them.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
