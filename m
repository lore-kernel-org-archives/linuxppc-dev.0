To: "Flavio Pereira" <fpereira@azisa.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linker problem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 22 Oct 2002 17:12:39 +0200."
             <1E354700654661418593A0D6B5A9D410089470@mail.azisa.co.za>
Date: Tue, 22 Oct 2002 19:41:57 +0200
Message-Id: <20021022174202.BC10810148@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Flavio,

in message <1E354700654661418593A0D6B5A9D410089470@mail.azisa.co.za> you wrote:
>
> Looks like it was a mistake that some people with term "useless" but hey
> I'm still learning. I was using LD directly to link and it doesn't
> automatically include the library files needed for c++. So when I
> switched to g++ for the linking it solved most of these system errors
> (__throw etc..). G++ however tries to include a -lstdg++ file which
> doesn't exist. So I had to use gcc and force link the libstdc++.a

You must be doing something wrong here. The g++ as included with  our
ELDK  does  not reference any "-lstdg++". Can you please show us some
(simple) exaqmple source and the exact command line you  use,  so  we
can test if there is really a problem, or just a usage error?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I can't say I've ever been lost, but I was bewildered once for  three
days.                                     - Daniel Boone (Attributed)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
