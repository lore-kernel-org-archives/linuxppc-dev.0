To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: "Billalabeitia, Jose Carlos (IndSys,     GEPM)" <jc.billalabeitia@indsys.ge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Formatting JFFS2 Flash 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 14 Mar 2002 11:31:38 GMT."
             <3C908A1A.3070102@cambridgebroadband.com>
Date: Thu, 14 Mar 2002 12:42:35 +0100
Message-Id: <20020314114240.64F3810BF4@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C908A1A.3070102@cambridgebroadband.com> you wrote:
>
> > 	2.- cp jffs2.image /dev/mtd0
>
> This looks wrong.  You should use
>
> cat jffs2.image > /dev/mtd0

Ummm... what's the difference?

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Don't panic.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
