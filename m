To: j.rakesh@gdatech.co.in
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc8245 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 20 Oct 2003 13:17:36 +0530."
             <200310200747.CAA19250@lists.linuxppc.org>
Date: Mon, 20 Oct 2003 17:01:48 +0200
Message-Id: <20031020150153.AC22CC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200310200747.CAA19250@lists.linuxppc.org> you wrote:
>
> I am working on mpc8245 based board. I have compiled the ppcboot with 64MB
> ram and its working fine and linux is ported successfully.
> But when I have configured the RAM to 182MB in ppcboot, I am getting the boot
> prompt and while loading linux its crashing . What can be the reason?

Your RAM initialization sequence is broken.

Also, 182 MB of RAM is a _very_ strange size.

Also, PPCBoot is a dead project. You shouls not use  it  for  current
work. You should rather switch to U-Boot instead.


And finally, all this is off toopic on  this  list,  and  you  should
rather post to U-Boot-Users.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"A witty saying proves nothing."                           - Voltaire

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
