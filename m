Date: Thu, 15 Nov 2001 21:24:18 -0800 (PST)
From: James F Dougherty <jfd@krakatoa.gigabitnetworks.com>
Message-Id: <200111160524.fAG5OI6U000706@krakatoa.gigabitnetworks.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Reading SDRAM Memory Configuration via EEPROM on SIMM
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Does anyone know how to read an SDRAM SIMM EEPROM
to get the memory configuration data? I remember
there was a spec for this ... forgot the name...

You basically read I2C data bytes from an EEPROM
in a standard format.... PC's do this to find memory
settings..


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
