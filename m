Message-ID: <37EB07F9.CBECEF6E@loomer.com>
Date: Thu, 23 Sep 1999 22:11:24 -0700
From: Hugh Caley <hcaley@loomer.com>
MIME-Version: 1.0
To: njolly@home.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: XFree86 3.3.5
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I had the same problem.  With experimentation I found out that 15 bpp and 32
bpp work, but not 16 and 24.  ??

Hugh

> I installed Xfree86-3.3.5, and the configuration tools, ran Xconfigurator,
> and rebooted. After much messing with my rc.local script (my fault it turns
> out)for a while I was able to get back to a command line, and test X. It
> turns oput I can only startx in 8 bit color or I get either Failed with
> signal 11 or no valid modes errors. I noticed In the announcment message that
> the X server will no longer run in 32 bit, but I am trying 16 bit and 24 bit
> as suggested, but with no success. Any suggestions would be greatly
> apprecaited as 8 bit looks gross with WindowMaker.
>
> Thanks all!
>
>
> - --
> Neil Jolly
>
--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
