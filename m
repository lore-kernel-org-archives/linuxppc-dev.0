To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: /dev/flash and MTD 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 09 Aug 2002 16:38:20 PDT."
             <3D54526C.80703@redswitch.com>
Date: Sat, 10 Aug 2002 10:37:48 +0200
Message-Id: <20020810083753.BA6F610DE1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Shawn,

in message <3D54526C.80703@redswitch.com> you wrote:
>
> WINDOW_SIZE. What does this difference mean? If I know the physical
> start address of flash memory and the size, is there a generic map
> driver available to do the probing? My general question is "do we need a
> MTD map driver for each board, especially for those custom boards?".

Actually we don't. Set  the  config  option  CONFIG_MTD_CMDLINE_PARTS
which  allows  the  use  of  a generic mapping driver and passing the
partitioning info from the command line.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Do not follow where the path may lead....go instead where there is no
path and leave a trail.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
