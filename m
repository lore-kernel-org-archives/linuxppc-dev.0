To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: value of XIP? and whether it works with 2.6 kernel? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 24 Aug 2004 11:44:16 EDT."
             <Pine.LNX.4.60.0408241141110.6489@localhost.localdomain>
Date: Wed, 25 Aug 2004 09:55:26 +0200
Message-Id: <20040825075531.ADD00C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0408241141110.6489@localhost.localdomain> you wrote:
>
>    as i read it from david w's post on the MTD list, XIP has limited
> value since flash is noticeably more expensive than RAM anyway.

The fact that flash is more expensive does NOT mean that XIP  has  no
use.  Actually  this  is nonsense. There are several good reasons why
using XIP may be a good idea. For example, in some security  critical
environments users are much more happy to execute code from read-only
storage. Also boot time may be an issue.

>    so, thoughts?  who's actually using this?  and it's not clear from
> the DENX page that there's a patch for the 2.6 kernel -- that page
> refers specifically to 2.4.

We use it on 2.4 with 8xx only (so far).

>    anyway, i'm just curious, wondering whether it would be worth giving
> it a try, just for the entertainment value.

Go on...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can observe a lot just by watchin'.                  - Yogi Berra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
