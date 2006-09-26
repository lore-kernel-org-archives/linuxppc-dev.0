Return-Path: <SRane@alphion.com>
Received: from alphion.com (unknown [66.147.184.82])
	by ozlabs.org (Postfix) with ESMTP id 816A067BB6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 00:34:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6E178.E3BF7CB7"
Subject: Need help to write I2C EEPROM device driver
Date: Tue, 26 Sep 2006 10:34:13 -0400
Message-ID: <8584FDC94AFF7640B17B8A89B23B19B34F658F@sbsserver.AlphionCorp.local>
From: "Sachin Rane" <SRane@alphion.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6E178.E3BF7CB7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am looking for an information to write a device driver to access =
EEPROM IC M24C02-WBN6.
The EEPROM IC M24C02-WBN is present on the 'ppc440' evaluation board for =
boot strap purpose.
=20
I have refferred materials available on:
1. some of the material available on www.lm-sensors.org =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org>  site
2. Device Driver code for EEPOM IC available on =
http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/013021.html =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://lists.lm-sen=
sors.org/pipermail/lm-sensors/2005-July/013021.html>=20
3. The documents available in "/usr/src/linux/Documentation/i2c" =
directory.
4. I2C Drivers, Part I  --> http://www.linuxjournal.com/node/7136/print =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.linuxjou=
rnal.com/node/7136/print>=20
   I2C Drivers, Part II  --> http://www.linuxjournal.com/node/7252/print =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.linuxjou=
rnal.com/node/7252/print>=20
5. Data sheet of IC M24C02-WBN6
6. I2C protocol document (Philips)
=20
But I am not getting a proper link which can help me to write a device =
driver.
=20
Could you  give me answer to my (silly) queries?
=20
Q1. Which way is more appropiate to access a EEPOM chip?
      ---- a. Accessing through Adapter device driver (adpter driver in =
turn will acess the chip device driver)
      ---- b. Or a /dev/ character device file node for the EEPROM IC =
(by registering a charcter device driver)
      As the IC is laying on the I2C bus with the Read (0xA0) and =
write(0xA1) address, I have to access it through Adapter device driver =
only.=20

Q2. As there are two address available for read and Write operation, at =
which address location the the i2c_probe() will find the device?

Q3. Can I use i2c_smbus_XXXXXXX functions to do interaction with the =
EEPROM I2C?
    ---- As per my understanding it should  work as SMB is subset of =
I2C.
=20
Q4. Where I can get the purpose of 'command' argument in =
'i2c_smbus_XXXX' functions from 'i2c.h'?
      extern s32 i2c_smbus_read_byte_data(struct i2c_client * client, u8 =
command);
      extern s32 i2c_smbus_write_byte_data(struct i2c_client * client, =
u8 command, u8 value);
      extern s32 i2c_smbus_read_word_data(struct i2c_client * client, u8 =
command);
      extern s32 i2c_smbus_write_word_data(struct i2c_client * client, =
u8 command, u16 value);
      extern s32 i2c_smbus_write_block_data(struct i2c_client * client, =
u8 command, u8 length, u8 *values);
       extern s32 i2c_smbus_read_i2c_block_data(struct i2c_client * =
client,  u8 command, u8 *values);
=20
Q4. Is there any guide available on Net for writing a I2C EEMPROM Chip =
device driver?
=20
=20
Regards,
Sachin Rane

Links that I have gone through:
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/doc>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/developers =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/doc/developers>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/chips/adm1024 =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/doc/chips/adm1024>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/developers =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/doc/developers>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/developers/new_dri=
vers =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/doc/developers/new_drivers>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/FAQ =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/doc/FAQ>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/prog>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/doc =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/prog/doc>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/eeprom =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/prog/eeprom>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/eeprom/ddcmon =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/prog/eeprom/ddcmon>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/eepromer =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/prog/eepromer>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/eepromer/24cXX.c =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/prog/eepromer/24cXX.c>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/eepromer/eeprom.c=
 =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/prog/eepromer/eeprom.c>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/eepromer/README =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/prog/eepromer/README>=20
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/eepromer/README.e=
eprom =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/browser/lm-sensors/trunk/prog/eepromer/README.eeprom>=20
http://www.lm-sensors.org/wiki/Devices =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/wiki/Devices>=20
http://www.lm-sensors.org/wiki/Documentation =
<https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.lm-senso=
rs.org/wiki/Documentation>=20

------_=_NextPart_001_01C6E178.E3BF7CB7
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>Hi,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>I am looking for an =
information to write a device driver to access EEPROM IC =
M24C02-WBN6.<BR>The EEPROM IC M24C02-WBN is present on the 'ppc440' =
evaluation board for boot strap purpose.</FONT></DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>I have refferred =
materials available on:<BR>1. some of the material available on <A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org" target=3D_blank>www.lm-sensors.org</A> site<BR>2. Device =
Driver code for EEPOM IC available on <A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://lists=
.lm-sensors.org/pipermail/lm-sensors/2005-July/013021.html" =
target=3D_blank>http://lists.lm-sensors.org/pipermail/lm-sensors/2005-Jul=
y/013021.html</A><BR>3. The documents available in =
"/usr/src/linux/Documentation/i2c" directory.<BR>4. I2C Drivers, Part =
I&nbsp; --&gt; <A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
inuxjournal.com/node/7136/print" =
target=3D_blank>http://www.linuxjournal.com/node/7136/print</A><BR>&nbsp;=
&nbsp; I2C Drivers, Part II&nbsp; --&gt; <A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
inuxjournal.com/node/7252/print" =
target=3D_blank>http://www.linuxjournal.com/node/7252/print</A><BR>5. =
Data sheet of IC M24C02-WBN6</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>6. I2C protocol document =
(Philips)</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>But I am not getting a =
proper link which can help me to write a device driver.</FONT></DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>Could you&nbsp; give me =
answer to my (silly) queries?</FONT></DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>Q1. Which way is more =
appropiate to access a EEPOM chip?<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
---- a. Accessing through Adapter device driver (adpter driver in turn =
will acess the chip device driver)<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
---- b. Or a /dev/ character device file node for the EEPROM IC (by =
registering a charcter device driver)</FONT></DIV>=0A=
<DIV><FONT face=3DArial color=3D#000000 =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; As the IC is laying on the I2C =
bus with the Read (0xA0) and write(0xA1) address, I have to access it =
through Adapter device driver only. </FONT></DIV><FONT face=3DArial =
color=3D#000000 size=3D2>=0A=
<DIV><BR>Q2. As there are two address available for read and Write =
operation, at which address location the the i2c_probe() will find the =
device?</DIV>=0A=
<DIV><BR>Q3. Can I use i2c_smbus_XXXXXXX functions to do interaction =
with the EEPROM I2C?</DIV>=0A=
<DIV>&nbsp;&nbsp;&nbsp; ---- As per my understanding it should&nbsp; =
work as SMB is subset of I2C.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Q4. Where I can get the purpose of 'command' argument in =
'i2c_smbus_XXXX' functions from 'i2c.h'?</DIV>=0A=
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extern s32 =
i2c_smbus_read_byte_data(struct i2c_client * client, u8 =
command);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extern s32 =
i2c_smbus_write_byte_data(struct i2c_client * client, u8 command, u8 =
value);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extern s32 =
i2c_smbus_read_word_data(struct i2c_client * client, u8 =
command);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;extern s32 =
i2c_smbus_write_word_data(struct i2c_client * client, u8 command, u16 =
value);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extern s32 =
i2c_smbus_write_block_data(struct i2c_client * client, u8 command, u8 =
length, u8 *values);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extern s32 =
i2c_smbus_read_i2c_block_data(struct i2c_client * client,&nbsp; u8 =
command, u8 *values);</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Q4. Is there any guide available on Net for writing a <STRONG>I2C =
EEMPROM Chip</STRONG> device driver?</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Regards,<BR>Sachin Rane</DIV>=0A=
<DIV><BR>Links that I have gone through:</DIV>=0A=
<DIV><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/doc" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/doc</A=
><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk</A><BR=
><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/doc/developers" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/de=
velopers</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/doc/chips/adm1024" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/ch=
ips/adm1024</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/doc/developers" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/de=
velopers</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/doc/developers/new_drivers" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/de=
velopers/new_drivers</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/doc/FAQ" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/FA=
Q</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/prog" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog</=
A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/prog/doc" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/d=
oc</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/prog/eeprom" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/e=
eprom</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/prog/eeprom/ddcmon" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/e=
eprom/ddcmon</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/prog/eepromer" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/e=
epromer</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/prog/eepromer/24cXX.c" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/e=
epromer/24cXX.c</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/prog/eepromer/eeprom.c" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/e=
epromer/eeprom.c</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/prog/eepromer/README" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/e=
epromer/README</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/browser/lm-sensors/trunk/prog/eepromer/README.eeprom" =
target=3D_blank>http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/e=
epromer/README.eeprom</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/wiki/Devices" =
target=3D_blank>http://www.lm-sensors.org/wiki/Devices</A><BR><A =
href=3D"https://mail.alphion.com/exchweb/bin/redir.asp?URL=3Dhttp://www.l=
m-sensors.org/wiki/Documentation" =
target=3D_blank>http://www.lm-sensors.org/wiki/Documentation</A></DIV></F=
ONT></FONT></DIV></BODY></HTML>
------_=_NextPart_001_01C6E178.E3BF7CB7--
