To: Dave Strout <dstrout@linuxfoundary.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ssh on ppc 405gp? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "20 May 2003 08:44:09 EDT."
             <1053434650.21004.7.camel@dstrout.nsw.enterasys.com>
Date: Tue, 20 May 2003 15:23:17 +0200
Message-Id: <20030520132322.D67E0C6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1053434650.21004.7.camel@dstrout.nsw.enterasys.com> you wrote:
>
> Thanks for the lead.  I've actually tried that, and I get:
> Disconnecting: Corrupted check bytes on input.

Are you absolutely sure that your network interface (and the rest  of
the  system, like RAM) is working correctly? This looks somewhat like
data corruption...

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Einstein argued that there must be simplified explanations of nature,
because God is not capricious or arbitrary. No  such  faith  comforts
the software engineer.                             - Fred Brooks, Jr.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
