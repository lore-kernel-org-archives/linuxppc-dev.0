To: "leo" <leo_guo@jisung.cn>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: which is the best root File system in embed linux system? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Apr 2004 23:32:17 +0800."
             <200404211533.KAA04470@lists.linuxppc.org>
Date: Wed, 21 Apr 2004 19:00:46 +0200
Message-Id: <20040421170051.74931C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200404211533.KAA04470@lists.linuxppc.org> you wrote:
>
> MPC852T target board with 8MB flash, which kind foot file system is the
> best selection among of:
...

You cannot optimize anything  without  spezifying  your  optimization
criteria  and  priorities.  What  is  important  for  you  - speed of
booting, memory footprint in RAM, memory footprint  in  flash,  being
able to write files to the filesystem, persistent sotrage of writtten
data, etc. etc.

What's best for my project is probably the worst for yours.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Plan to throw one away.  You will anyway."
                              - Fred Brooks, "The Mythical Man Month"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
