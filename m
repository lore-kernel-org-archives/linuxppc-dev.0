Date: Thu, 30 Oct 2003 10:29:33 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: 866 derived RTC handling
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3FA0313D.2070203@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings

Has anyone tackled the lack of a Real Time Clock block in the mpc866
(and its derivatives)? As far as I can see, the changing of platform_init()
         ppc_md.set_rtc_time             = m8xx_set_rtc_time;
         ppc_md.get_rtc_time             = m8xx_get_rtc_time;
to
         ppc_md.set_rtc_time             = NULL;
         ppc_md.get_rtc_time             = NULL;
based on the CPU will do the trick - but the question is, what is the
best way to identify the subclass of 866 within the 8xx family of CPUs.

The IMMR mask version of 0x08000003 seems one way, is this consistant
does anyone know? I'd like to avoid the introduction of (yet another)
config item so a probe would be best IMHO.


--
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
