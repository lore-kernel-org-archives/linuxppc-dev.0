Message-ID: <20021210231853.23902.qmail@web41203.mail.yahoo.com>
Date: Tue, 10 Dec 2002 15:18:53 -0800 (PST)
From: Prakash kanthi <pkanthi@yahoo.com>
Subject: Board specific info for no EEPROM case
To: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20021206024109.S1931@mind.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Folks,

I do not have a NVRAM or EEPROM on my board (PPC405
based). I see that during the linux booting, it is
trying to read bd_t info from EEPROM and failing. Is
there an alternative to this problem? Can i hardcode
the stuff in decompress_kernel method and go ahead?

thanks,
Prakash


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
