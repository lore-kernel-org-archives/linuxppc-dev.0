To: ashish anand <ashisha@india.infogain.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: RAM reqd. for browser email client application.. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 17 Oct 2001 06:44:42 +0530."
             <3BCCDB82.CB584200@india.infogain.com>
Date: Wed, 17 Oct 2001 14:25:45 +0200
Message-Id: <20011017122550.E002A10889@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BCCDB82.CB584200@india.infogain.com> you wrote:
>
> I am going to use a browser application and email client on a powerpc based SBC(mpc823)
> with RTLINUX as OS , and a LCD pannel connected.

Do you really need RTLinux? I guess this is  _not_  fro  the  browser
and/or email part of your application...

> if anyone can give me a rough idea how much RAM i need for that , it would be great help.

You can probably squeeze it in 8 MB, but  you  will  feel  much  more
comfortable  with 16 MB. Of course, you could have strange ideas like
running a full-blown X11 and maybe even  Netscape  -  then  you  need
MORE.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Computers are not intelligent. They only think they are.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
