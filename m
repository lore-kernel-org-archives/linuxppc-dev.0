Date: Thu, 12 Dec 2002 14:52:43 -0700
From: Matt Porter <porter@cox.net>
To: Aman <aman@mistralsoftware.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: NVRAM/RTC
Message-ID: <20021212145243.A5263@home.com>
References: <000901c2a20b$23472400$370da8c0@aman>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000901c2a20b$23472400$370da8c0@aman>; from aman@mistralsoftware.com on Thu, Dec 12, 2002 at 11:50:23PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 12, 2002 at 11:50:23PM +0530, Aman wrote:
>
> Hi All
>
> I have customized board , which has PPC 440GP as its processor. In this
> board there is no NVRAM/RTC as in the 440GP evalkit. In the Rom monitor,
> configuration related to it NVRAM/RTC has been removed. Because of this
> changes in the rom monitor code, the linux image is hanging after " Now
> Booting the Kernel". If  NVRAM/RTC EBC bank1 is enabled in rom monitor, the
> linux image is executing without any problem. Can anyone say , how to
> disable the NVRAM/RTC option in the linux kernel.

Are you trying to run an ebony image on this board?  Sounds like it,
and that would be the wrong thing to do.  Make a new port, and
in your <board>.c file, don't ioremap the RTC area (since you don't
have one) and delete (or set NULL) all the time/nvram machdeps.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
