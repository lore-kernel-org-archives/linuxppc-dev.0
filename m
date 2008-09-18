Return-Path: <AymanE@tanisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Device tree configuration for I2C eeprom
Date: Thu, 18 Sep 2008 14:44:44 -0500
Message-ID: <16691A8B34B5D9458EA3A1C37A11555A0137F7B6@tanisys-ex2.Tanisys.Local>
From: "Ayman El-Khashab" <AymanE@tanisys.com>
To: <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am eluded by how exactly to configure the device tree for my external
I2C eeprom AND once that happens, how do I use the eeprom driver for
linux to read/write the device.

I am using the newest kernel 2.6.27-rc6 since it has apparently the best
support for the 28C128 EEPROM devices.  My design is based on the
canyonlands PPC460EX board.
=20
The RTC in the device tree shows up as expected in the
/proc/device-tree, but I am not sure what the configuration of the
eeprom should look like. =20

Here is a snippet from the dts file, and I assume I need something like
what I've added:
=20
                        IIC0: i2c@ef600700 {
                                compatible =3D "ibm,iic-460ex", =
"ibm,iic";
                                reg =3D <ef600700 14>;
                                interrupt-parent =3D <&UIC0>;
                                interrupts =3D <2 4>;
                                #address-cells =3D <1>;
                                #size-cells =3D <0>;
                                rtc@68 {
                                        compatible =3D "stm,m41t80";
                                        reg =3D <68>;
                                };
                                eeprom@50 {
                                        compatible =3D "?????";
 						    something
                                        something;
                                };
   =20
Once I do all that, how does one use the eeprom driver to read and write
this part?

Thanks
