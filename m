Date: Fri, 16 Nov 2001 09:58:09 -0500
Message-Id: <200111161458.fAGEw9L01007@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: jfd@krakatoa.gigabitnetworks.com
Cc: linuxppc-embedded@lists.linuxppc.org
In-reply-to: <200111160524.fAG5OI6U000706@krakatoa.gigabitnetworks.com>
	(message from James F Dougherty on Thu, 15 Nov 2001 21:24:18 -0800
	(PST))
Subject: Re: Reading SDRAM Memory Configuration via EEPROM on SIMM
References: <200111160524.fAG5OI6U000706@krakatoa.gigabitnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Does anyone know how to read an SDRAM SIMM EEPROM
>to get the memory configuration data? I remember
>there was a spec for this ... forgot the name...

Its called "Serial Presence Detect", and you can find the spec at:

http://developer.intel.com/technology/memory/pc133sdram/spec/spdsd12b.htm

--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
