To: "S. Hebbar" <shebbar@india.tejasnetworks.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: denx 2.4.20 kernel memory leak 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 Mar 2004 14:44:15 +0530."
             <200403031444.15398.shebbar@india.tejasnetworks.com>
Date: Wed, 03 Mar 2004 10:56:35 +0100
Message-Id: <20040303095640.401CDC0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200403031444.15398.shebbar@india.tejasnetworks.com> you wrote:
>
> I am noticing kernel memory leak when I am getting a file using ftp.
> For each ftp get session, the skbuff_head_cache is increasing.
...
> I am using denx 2.4.20 kernel. My target processor is MPC8260.

Please update. This is a known problem that has been fixed since:

---------------------
PatchSet 169
Date: 2004/01/08 17:38:41
Author: wd
Branch: HEAD
Tag: (none)
Log:
Patch by Wojciech Kromer, 06 Jan 2004:
Fix sk_buff memory leak problem in 82xx FCC driver.

Members:
        arch/ppc/8260_io/fcc_enet.c:1.7->1.8

---------------------


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
1st Old Man:  Gee, its windy today.
2nd Old Man:  No it's not... it's Thursday.
3rd Old Man:  Yeh, me too.  Let's go for a beer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
