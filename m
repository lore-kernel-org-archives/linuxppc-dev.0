To: bhavin <bhavinp@einfochips.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with PM826 card 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Sep 2003 19:40:20 +0530."
             <3F5747CC.5060107@einfochips.com>
Date: Thu, 04 Sep 2003 16:17:58 +0200
Message-Id: <20030904141803.8AD0BC59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Bhavin,

in message <3F5747CC.5060107@einfochips.com> you wrote:
>
>    Thanks a bunch for your guidance. It helped a lot. I was able to
> download my Linux image to memory and in flash memory after through cp.
> But in both the cases when I tried to boot my linux,  the setup got
> restarted after giving the message

And again this is a user error which could have been avoided had  you
read the documentation (like the README that comes with U-Boot).

>    Image Name:   2.4.5-pre1 initrd for PM826

I recommend NOT to attempt to use  a  2.4.5-pre1  kernel.  The  PM826
board  is  supported by our 2.4.4 and 2.4.20 kernel trees. 2.4.5-pre1
will most likely NOT run.

>    Load Address: 00000000
>    Entry Point:  0000000c

Also, for all 2.4.x kernels the entry point address is 0x0000.

> Could any one please help me what could be the possible problem as I am
> totally new to this area. Or If I can get some pointer on where to look
> for this trouble It would be a great help.

If you are new you should probably  start  using  tested  components,
like  our 2.4.4 or 2.4.20 kernel trees instead of completely untested
2.4.5-pre1. See also http://www.denx.de/re/linux.html

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Plan to throw one away. You will anyway."
                              - Fred Brooks, "The Mythical Man Month"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
