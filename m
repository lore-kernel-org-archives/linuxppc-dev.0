To: Marc Leeman <marc.leeman@barco.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] u-boot 1.1.1 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 May 2004 15:46:38 +0200."
             <20040510134638.GW14935@smtp.barco.com>
Date: Tue, 11 May 2004 21:24:53 +0200
Message-Id: <20040511192458.48159C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marc,

in message <20040510134638.GW14935@smtp.barco.com> you wrote:
>
> oops:
>
>  -    CONFIG_READ_BYTE(PCMBRCR,val);
>  +    CONFIG_READ_BYTE(PCMBCR,val);

I told you before:

This is not the right place for  U-Boot  patches.  Please  send  such
stuff  to  the  U-Boot-Users  mailing  list.  And  please  follow the
instructions in the README ("Submitting Patches").


Do you think I will search 850k+ lines of code? And actually no  such
line appears anywhere in the current U-Boot code.

If you have something to report, please do  it  on  the  U-Boot-Users
mailing list, and do it in a usable form.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Always leave room to add an explanation if it doesn't work out.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
