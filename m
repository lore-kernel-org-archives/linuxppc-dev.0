Return-Path: <pochini@shiny.it>
Received: from out4.alice.it (smtp-out04.alice.it [85.37.17.100])
	by ozlabs.org (Postfix) with ESMTP id 66ED8679A6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 09:14:40 +1100 (EST)
Date: Tue, 28 Mar 2006 00:01:09 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: KW: wrong state
Message-Id: <20060328000109.4174e00a.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Dual G4 MDD,
Linux Jay 2.6.16 #2 SMP Sun Mar 26 00:19:01 CET 2006 ppc 7455, altivec supported PowerMac3,6 GNU/Linux
writes these messages at boot. The fan control seems to work fine, though.

i2c /dev entries driver
PowerMac i2c bus pmu 2 registered
PowerMac i2c bus pmu 1 registered
PowerMac i2c bus mac-io 0 registered
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 06)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
PowerMac i2c bus uni-n 1 registered
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
DS1775 digital thermometer [@49]
Temp: 24.5 C  Hyst: 75.0 C  OS: 80.0 C
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
ADM1030 fan controller [@2c]
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
KW: wrong state. Got KW_I2C_IRQ_ADDR, state: state_stop (isr: 02)
PowerMac i2c bus uni-n 0 registered


I cannot stop the second CPU with "echo 0 > /sys/devices/system/cpu/cpu1/online"
dmesg says "CPU 1 refused to die!". I don't know if it's related to the errors above.


--
Giuliano.
