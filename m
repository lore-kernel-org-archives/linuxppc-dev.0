Message-Id: <200001141713.SAA04129@denx.local.net>
To: Jim Chapman <jim.chapman@iname.com>
Cc: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cross-compile Applications for 860 on x86 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 14 Jan 2000 11:50:25 GMT."
             <387F0D81.48F7CABE@iname.com>
Date: Fri, 14 Jan 2000 18:13:11 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <387F0D81.48F7CABE@iname.com> Jim Chapman wrote:
> 
> Do "-ls" at the prompt, not "ls". Prepending "-" runs sash's builtin
> versions, otherwise it will try to find a ls on your ramdisk like any
> other shell. See sash's man page about all available builtin commands.

Or just type "help"

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Overdrawn?  But I still have checks left!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
