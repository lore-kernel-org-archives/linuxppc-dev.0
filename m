To: "Tord Andersson" <tord.andersson@its4mobility.com>
Cc: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC823e Video Framebuffer Driver 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 29 Jan 2002 17:06:46 +0100."
             <001701c1a8df$05796620$2c80a8c0@vms.se>
Date: Tue, 29 Jan 2002 17:34:08 +0100
Message-Id: <20020129163413.2EF6C109D5@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Tord,

in message <001701c1a8df$05796620$2c80a8c0@vms.se> you wrote:
>
> Does anyone know where to find the source to a MPC823e Video Framebuffer
> driver.

See ftp://ftp.denx.de/pub/LinuxPPC/usr/src/linux-2.4.4-2002-01-19.tar.bz2

The included driver has been tested on HLD1045, NEC  NL6448AC33,  NEC
NL6448BC20_08, and SHARP LQ64D341 displays.

We have also a version of our SELF package  which  includes  a  small
demo program (just load and display a test image) using Microwindows.
Let  me know if you're interested [I will put it up on our FTP server
anyway, but I have more urgent things to do at the moment].

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The high cost of living hasn't affected its popularity.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
