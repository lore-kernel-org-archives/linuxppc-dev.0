Date: Tue, 10 Dec 2002 17:10:55 -0700
From: Matt Porter <porter@cox.net>
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Board specific info for no EEPROM case
Message-ID: <20021210171055.A32292@home.com>
References: <20021206024109.S1931@mind.be> <20021210231853.23902.qmail@web41203.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021210231853.23902.qmail@web41203.mail.yahoo.com>; from pkanthi@yahoo.com on Tue, Dec 10, 2002 at 03:18:53PM -0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 10, 2002 at 03:18:53PM -0800, Prakash kanthi wrote:
>
> Hi Folks,
>
> I do not have a NVRAM or EEPROM on my board (PPC405
> based). I see that during the linux booting, it is
> trying to read bd_t info from EEPROM and failing. Is
> there an alternative to this problem? Can i hardcode
> the stuff in decompress_kernel method and go ahead?

There are a pile of examples of this very thing in
arch/ppc/boot/simple/embed_config.c.  Create an
embed_config() and hardcode your board-specific values
into the bd_t.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
