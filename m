To: bart@ardistech.com
Cc: govindan@india.tejasnetworks.com, svacca@valcom.com,
	"LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>,
	govindan@tejasnetworks.com
Subject: Re: Execute Reset via CheckStop approach 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Aug 2002 12:47:22 +0200."
             <3D6612BA.730D7A25@ardistech.com>
Date: Fri, 23 Aug 2002 13:33:21 +0200
Message-Id: <20020823113326.5A43F11822@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3D6612BA.730D7A25@ardistech.com> you wrote:
>
> But this is not enough. It looks like the CHSTP bit in the DER (Debug Enable
> Regsiter) is set preventing the HRESET_N sequence from the CPU. This DER is
> not a normal special register. Do you have an example how I can clear it?

The DER should be set by your formware. Fix this!

And the DER _is_ a normal special register (# 149).


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
...when fits of creativity run strong, more than  one  programmer  or
writer  has  been  known to abandon the desktop for the more spacious
floor.                                             - Fred Brooks, Jr.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
