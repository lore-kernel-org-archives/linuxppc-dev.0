To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: large file support? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 31 Jul 2003 12:30:46 +0200."
             <3F28EFD6.3070803@imc-berlin.de>
Date: Thu, 31 Jul 2003 13:37:19 +0200
Message-Id: <20030731113724.CB20BC602D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3F28EFD6.3070803@imc-berlin.de> you wrote:
>
> how could I find out if the kernel and the glibc I am using will
> correctly supprot large files (>2GB)?

	char buf[4096];
	for (;;)
		write (fd, buf, sizeof(buf));

:-)


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Perl already has an IDE.  It's called Unix.
                      -- Tom Christiansen in 375bd509@cs.colorado.edu

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
