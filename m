Subject: Re: Serial
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Wed, 30 Aug 2000 12:17:32 +1100 (EST)
Cc: tachyon@postech.ac.kr (Hyun-Joon Cha)
In-Reply-To: <200008290758.JAA02594@denx.local.net> from "Wolfgang Denk" at Aug 29, 2000 09:58:27 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000830011732.526F1231@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk writes:
> > 1. Can I expect some performance gain with removal?
...
> Linux will not run any faster when you remove the serial driver  from
> the boot loader.

Well, it will boot quite a bit quicker.  If you have no serial port, or are
building a production system with no need for kernel messages, it's possible
to reduce boot time and kernel memory usage with my CONFIG_MESSAGES patch,
at:
    http://members.xoom.com/greyhams/linux/patches/2.2/messages.patch

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
