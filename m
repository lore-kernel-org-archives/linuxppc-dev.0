Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <40B5F176.2020805@ztec.com.br>
Date: Thu, 27 May 2004 10:47:34 -0300
From: iida <iida@ztec.com.br>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: how to use the i2c in mpc5200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


i am using the linuxppc-2.4.25-denx and loaded
this modules

Module                  Size  Used by    Not tainted
i2c-icecube             1680   0 (unused)
i2c-algo-mpc5xxx        4048   0 [i2c-icecube]
i2c-core               18768   0 [i2c-algo-mpc5xxx]
when i loaded the i2c-icecube i recived the message

i2c-algo-5xxx.o: scanning bus Icecube I2C module #2 interface...
................................................................................(0x50)..............................................(0x7f)
i2c-icecube.o: I2C module #2 installed

i created the i2c with
mknod /dev/i2c c 89 1


i am used the i2c-demo from bsp of the metrowerks
but i recived the message


*** Pass the write-string optionally as argument ***
/dev/i2c open: No such device
eeprom_read: Illegal seek
/dev/i2c open: No such device
/dev/i2c open: No such device
eeprom_read: Illegal seek



what am i doing wrong ?

Thanks

Renato


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
