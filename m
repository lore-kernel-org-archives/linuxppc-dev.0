To: "William A. Smith" <bsmith@iphase.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MCIP805: New Linux Boot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 09 Sep 2002 11:05:43 CDT."
             <5.1.1.6.2.20020909104632.0356dd20@mailhost.iphase.com>
Date: Mon, 09 Sep 2002 18:39:08 +0200
Message-Id: <20020909163913.E4CB9FA8B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Bill,

in message <5.1.1.6.2.20020909104632.0356dd20@mailhost.iphase.com> you wrote:
>
> I'm new to embedded PPC Linux.  Does anyone have a link to a good webpage
> explaining how to make a ramdisk- or flash-based CPU boot from the rebuilt
> kernel image I have?  This is a Motorola MCIP805 CPU.

See http://www.denx.de/doc/TQM8xxL/ for an example, allthough  for  a
different board.

To build a ramdisk image you could use our SELF package as a starting
point, see ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/

BTW: maybe the IPHASE4539 config option is a bit familiar to you :-)


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
