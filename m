To: "leeyang" <leeyang@ycig.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ELDK 2.0 released 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 06 Nov 2002 17:46:56 +0800."
             <001d01c28579$7216d070$cc00a8c0@ycigrnd.ycig.com>
Date: Wed, 06 Nov 2002 19:17:41 +0100
Message-Id: <20021106181746.2B21C10160@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001d01c28579$7216d070$cc00a8c0@ycigrnd.ycig.com> you wrote:
> I use the follwoing command line to install
> without root account
> ./install -d /eldk2.0.2 ppc_8xx
> ....
> warning:user wd does not exist, using root
> .....

Yes, I'm sorry, but I mistakenly ran the final build under my own id,
which was  not  noticed  here  because  I  have  an  account  on  all
machines...

> and it ends up successfully.
>
> Does it affect works?

No, it has absolutely no  consequences.  The  tools  will  work  fine
anyway.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ electronica 2002 in Munich, Nov 12-15, Hall A3, Booth A3.325

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
