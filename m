To: Eugene Surovegin <ebs@ebshome.net>
Cc: Matt Porter <mporter@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: set_rtc_time() cleanup / normalization 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 May 2003 21:52:21 PDT."
             <5.1.0.14.2.20030513214040.02a6e6d0@mail.ebshome.net>
Date: Wed, 14 May 2003 08:47:24 +0200
Message-Id: <20030514064729.EA230C6092@atlas.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <5.1.0.14.2.20030513214040.02a6e6d0@mail.ebshome.net> you wrote:
>
> There is other thing which bothers me.
> Why PPC arch should be different in this respect from other archs (like
> i386, alpha, mips, mips64, sparc...)?

Because other architectures  already  are  different  than  PPC.  For
example  on  ARM  the  implementation is board-dependend. Some boards
don't call set_rtc_time() in their timer interrupt handlers.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Don't tell me how hard you work.  Tell me how much you get done.
                                                     -- James J. Ling

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
