To: byf <byfmail@yeah.net>
Cc: embeded powerpc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How to use loads to load kernel? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 24 Apr 2001 11:22:01 +0800."
             <20010424032233.D58AE1CA239C9@smtp2.yeah.net>
Date: Tue, 24 Apr 2001 08:54:10 +0200
Message-Id: <20010424065415.822CE2792B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010424032233.D58AE1CA239C9@smtp2.yeah.net> you wrote:
>
> I have a question about ppcboot, how to use loads to load kernel to ram via serial?
> where the kernel should be put in host?

Please use the PPCBoot mailing list for PPCBoot related questions.

The answer to your question depends on the  terminal  program  you're
using. With "cu" (recommended when you use "loads") you use the "send
file" command ("~>filename").

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can do this in a number of ways.     IBM chose to do all of them.
Why do you find that funny?        -- D. Taylor, Computer Science 350

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
