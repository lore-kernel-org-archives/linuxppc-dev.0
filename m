To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kernel boot up without using PPCBOOT from flash 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 09 Aug 2003 04:19:08 PDT."
             <20030809111908.47795.qmail@web8005.mail.in.yahoo.com>
Date: Sun, 10 Aug 2003 00:22:53 +0200
Message-Id: <20030809222258.E8EDCC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030809111908.47795.qmail@web8005.mail.in.yahoo.com> you wrote:
>
> I wrote the pMulti image into flash 2a00000
> ppcboot is at location 2800000
> i did the following settings
> setenv bootcmd bootm 0x2a00000
> and also  did saveenv ...
> once i reset the board it just hangs thats it...

This description does NOT match the log you show below:

> =>setenv bootcmd bootm 2a00000
> =>saveenv
> Saving Enviroment to Flash...
> Un-Protected 1 sectors
> Erasing Flash...
> . done
> Erased 1 sectors
> Writing to Flash... done
> Protected 1 sectors
> =>Ã  it hangs  at this point.
>  how do i go about this problem ?

Judging from this output it seems that the board hangs as soon as you
performed the "saveenv" command. Where is the environment  stored  on
your  board? To me this looks like the environment placement for your
board was not configured correctly in U-Boot.

Umm... but this is off topic here.  Let's  move  this  discussion  to
u-boot-users, please.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"On two occasions I have been  asked  [by  members  of  Parliament!],
'Pray,  Mr.  Babbage, if you put into the machine wrong figures, will
the right answers come out?' I am not able rightly to  apprehend  the
kind of confusion of ideas that could provoke such a question."
- Charles Babbage

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
