To: Jin Cheng <jcheng@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MDPPro850 or EST8240 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 15 Apr 2002 12:05:28 PDT."
             <3CBB2478.A92C8C65@redswitch.com>
Date: Mon, 15 Apr 2002 21:08:10 +0200
Message-Id: <20020415190815.4BFF611259@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CBB2478.A92C8C65@redswitch.com> you wrote:
>
> Anyone had successfully put ppcboot on the MDPPro850 or EST 8240 board?

Nobody that I know of.

> I am trying to put ppcboot on MDPPro 850, but it always stop after
> printing:
> DRAM : 0MB

Obviously either your RAM initialization and/or your RAM sizing  code
is broken.

Better help probably on the ppcboot mailing list; you  can  subscribe
at http://lists.sourceforge.net/lists/listinfo/ppcboot-users

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
To get something done, a committee should consist  of  no  more  than
three men, two of them absent.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
