To: "Oliver Fuchs" <olivers.lists@gmx.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does ext2 based on MTD acceptable for Embedded Development? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 27 Aug 2004 09:08:23 +0200."
             <412EFA07.27872.405FEB@localhost>
Date: Fri, 27 Aug 2004 09:39:57 +0200
Message-Id: <20040827074002.58692C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <412EFA07.27872.405FEB@localhost> you wrote:
>
> > still want to consult with you such a question.Dose
> > ext2 filesystem besed on MTD a acceptable option?
>
> I would not use ext2 on MTD.

We do, and it works perfect. You just want to make sure to  mount  it
read-only.

> JFFS2 is much better for that purpose for in contrast to ext2, it is
> power down reliable and performs wear leveling.

These  features  are  only  interesting  when  you  need  a  writable
filesystem.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Program maintenance is an entropy-increasing process,  and  even  its
most skilfull execution only delays the subsidence of the system into
unfixable obsolescence.       - Fred Brooks, "The Mythical Man Month"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
