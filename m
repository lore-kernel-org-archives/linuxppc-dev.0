Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8245 and PCF8563 RTC
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1059084423.4969.11.camel@triffo.arlut.utexas.edu>
Mime-Version: 1.0
Date: 24 Jul 2003 17:07:04 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Has anyone had any success using an MPC8245 and a Philips PCF8563 real
time clock in linux? Everything works in U-Boot but I can not get
everything working in linux.

I am using the MPC8245 I2C drivers from:
http://www.humboldt.co.uk/mpc10xi2c.html
and I am using the PCF8563 drivers from the CVS DENX Linux kernel.

I know I2C works in linux because the two LM75 temperature sensors on
the board work. However the PCF8563 driver does not work. I have
debugging turned on for both the i2c-adap-mpc10x and pcf8563 kernel
modules and I get output that looks like this:

rtc_rd(): i2c transfer error
i2c-adap-mpc10x.c: Doing write 1 bytes to 0x51 - 1 of 2 messages
i2c-adap-mpc10x.c: Doing read 1 bytes to 0x51 - 2 of 2 messages
rtc_rd(): i2c transfer error
Alarms: wday: ff day: ff hour: ff min: ff
PCF8563 RTC Low Voltage - date/time not reliable
get rtc [dec] year=2165 mon=25 day=45 hour=45 min=85 sec=85
Set System Time from RTC Time: 1925913489
RTC installed, minor 135
i2c-adap-mpc10x.c: Doing write 1 bytes to 0x51 - 1 of 2 messages
i2c-adap-mpc10x.c: Doing read 1 bytes to 0x51 - 2 of 2 messages
rtc_rd(): i2c transfer error
PCF8563 RTC Low Voltage - date/time not reliable
i2c-adap-mpc10x.c: Doing write 2 bytes to 0x51 - 1 of 1 messages
rtc_wr(): i2c transfer error
i2c-adap-mpc10x.c: Doing write 2 bytes to 0x51 - 1 of 1 messages
rtc_wr(): i2c transfer error
i2c-adap-mpc10x.c: Doing write 2 bytes to 0x51 - 1 of 1 messages
rtc_wr(): i2c transfer error
i2c-adap-mpc10x.c: Doing write 1 bytes to 0x51 - 1 of 2 messages
i2c-adap-mpc10x.c: Doing read 1 bytes to 0x51 - 2 of 2 messages
rtc_rd(): i2c transfer error

Obviously it has a transfer error, but I am curious if anyone has any
experiences with the same situation. Anyone have any ideas?

Thanks,
Matthew


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
