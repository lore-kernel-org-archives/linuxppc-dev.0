To: Jeff Tucker <jeff@jltnet.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need help booting linux on IBM 405EP eval board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 02 Apr 2004 12:34:56 CDT."
             <1866383.1080909296@[192.168.0.230]>
Date: Fri, 02 Apr 2004 20:51:02 +0200
Message-Id: <20040402185107.B77E5C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1866383.1080909296@[192.168.0.230]> you wrote:
>
> I sent a message like this to the U-Boot mailing list last night. I've been

And you have received replies thaty pointed to the problem.

> I'm aware that the denx.de site has a FAQ which appears to address this issue:
> <http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel>
>
> However, the structure mentioned there (bd_info) doesn't even seem to apply
> for a 405EP-based board. The ppcboot.h file isn't included by the files
> used when building a 405EP kernel for the 405EP evaluation board.

OK. You found the problem: The ppcboot.h file isn't  included.  Seems
you  must  adapt  your  board for use with U-Boot. See the FAQ quoted
above.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Data is a lot like humans: It is  born.  Matures.  Gets  married  to
other  data, divorced. Gets old. One thing that it doesn't do is die.
It has to be killed."                                 - Arthur Miller

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
