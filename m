To: "Flavio Pereira" <fpereira@azisa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linker problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 22 Oct 2002 09:54:32 +0200."
             <1E354700654661418593A0D6B5A9D41008946D@mail.azisa.co.za>
Date: Tue, 22 Oct 2002 10:12:01 +0200
Message-Id: <20021022081206.6E71310145@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1E354700654661418593A0D6B5A9D41008946D@mail.azisa.co.za> you wrote:
>
> Im trying to cross compile some c++ code for the 8260 chip. However when
> the linker executes it return the following error:
>
> undefined reference to `__throw'

Can you show us your example  code,  and  the  commands  you  use  to
compile and link it?

Does it work with the native (x86) C++ compiler?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Make it right before you make it faster.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
