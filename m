To: quan.zechang@zte.com.cn
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: any one can help me? problem about install ELDK 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 15 Oct 2003 14:42:37 +0800."
             <OF4261606D.01F5B29B-ON48256DC0.00245225@com.cn>
Date: Wed, 15 Oct 2003 15:12:03 +0200
Message-Id: <20031015131208.659E9C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <OF4261606D.01F5B29B-ON48256DC0.00245225@com.cn> you wrote:
>
>   when i am installing the ELDK ,the install software print the error
> message:
> any one can tell me the method resolving the problem?thank you !
>
> Do you really want to install into /home/achang/program_files/eldk
> directory[y/n]?: y
>
> Installing cross RPMs
>
> /bin/sh: line 1: /home/achang/program_files/eldk/bin/rpm: No such file or
> directory

Obviously you did not download all the required files. At  least  the
file "bin/rpm" seems to be missing.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Today is the yesterday you worried about tomorrow.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
