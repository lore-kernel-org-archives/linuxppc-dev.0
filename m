To: Marius Groeger <mag@sysgo.de>
Cc: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: make module_install 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 Dec 2002 19:12:36 +0100."
             <Pine.LNX.4.40.0212171909030.11803-100000@mag.devdep.sysgo.de>
Date: Tue, 17 Dec 2002 19:33:37 +0100
Message-Id: <20021217183342.47AE8C6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.40.0212171909030.11803-100000@mag.devdep.sysgo.de> you wrote:
>
> > driver anyway. I will even go so far to say that if you need  to  run
> > "depmod"  for  your embedded system you should fix your system design
> > because you are doing something wrong.
>
> Someone might use loadable modules because he doesn't want to release
> his driver under the GPL. I wouldn't exactly consider this wrong.

I do not intend to comment on the issue of binary modules.

But even in such a situation  the  necessity  to  run  depmod  in  an
embedded  system is IMHO an indication of a potential design problem.
Things should be kept simple.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
No user-servicable parts inside. Refer to qualified service personnel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
