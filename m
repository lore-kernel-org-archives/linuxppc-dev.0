To: Jon Fridriksson <jonff@control.auc.dk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Cannot boot properly 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 Apr 2002 19:01:36 +0200."
             <3CADD870.4050200@control.auc.dk>
Date: Fri, 05 Apr 2002 20:54:56 +0200
Message-Id: <20020405185501.26DD011250@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jon,

in message <3CADD870.4050200@control.auc.dk> you wrote:
>
> >If this i the case, you have mis-configured the  serial  ports.  Make
> >sure  to  enable  both SMC1 and SMC2 in the kernel configuration, and
> >select the right one as console port. Also make sure that you  select
> >CONFIG_ALTSMC2.
> >
>
> Done that and now it works !!

Congratulations!

> Thank you for your quick response

You're welcome!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Use C++ to confuse your enemies; use C to produce stable code.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
