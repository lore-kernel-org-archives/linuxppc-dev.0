To: Stephen Williams <steve@icarus.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Embedded SDRAM memory tester 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Aug 2004 15:42:12 PDT."
             <41140944.2060704@icarus.com>
Date: Sat, 07 Aug 2004 08:21:21 +0200
Message-Id: <20040807062126.8EF1BC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <41140944.2060704@icarus.com> you wrote:
>
> To that end, a memory tester a la memtest86 would be really really
> nice. Especially if it is bootable via u-boot:-)

All of the memtest86 code (and  a  little  more)  _is_  available  in
U-Boot. Just enable it in the configuration.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Once they go up, who cares where  they  come  down?  That's  not  my
department."                                       - Werner von Braun

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
