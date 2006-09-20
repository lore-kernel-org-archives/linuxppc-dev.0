Return-Path: <SRane@alphion.com>
Received: from alphion.com (unknown [66.147.184.82])
	by ozlabs.org (Postfix) with ESMTP id B9238679FD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Sep 2006 01:08:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DCC6.A1127019"
Subject: Couldn't find reference for i2c_smbus functinos
Date: Wed, 20 Sep 2006 11:07:52 -0400
Message-ID: <8584FDC94AFF7640B17B8A89B23B19B34F6576@sbsserver.AlphionCorp.local>
References: <8584FDC94AFF7640B17B8A89B23B19B34F6573@sbsserver.AlphionCorp.local>
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

------_=_NextPart_001_01C6DCC6.A1127019
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
Following text is from "/usr/local/linux/Doumentation/dev-interface":
-------------------------------------------------------------------------=
---------------------------------------------------------
You can do SMBus level transactions (see documentation file =
smbus-protocol
for details) through the following functions:
  __s32 i2c_smbus_write_quick(int file, __u8 value);
  __s32 i2c_smbus_read_byte(int file);
  __s32 i2c_smbus_write_byte(int file, __u8 value);
  __s32 i2c_smbus_read_byte_data(int file, __u8 command);
  __s32 i2c_smbus_write_byte_data(int file, __u8 command, __u8 value);
  __s32 i2c_smbus_read_word_data(int file, __u8 command);
  __s32 i2c_smbus_write_word_data(int file, __u8 command, __u16 value);
  __s32 i2c_smbus_process_call(int file, __u8 command, __u16 value);
  __s32 i2c_smbus_read_block_data(int file, __u8 command, __u8 *values);
  __s32 i2c_smbus_write_block_data(int file, __u8 command, __u8 length,
                                   __u8 *values);
-------------------------------------------------------------------------=
--------------
=20
I searched in the 2.6.13 version of Timesys and Suse linux, but I didn't =
find definition or declaration in file '/usr/include/linux/i2c-dev.h' =
and '/usr/include/linux/i2c.h'.
=20
Am I missing any information about the location of the above functions?
Do I need to implement the above functions?
=20
Thanks and Regards,
Sachin Rane
=20

------_=_NextPart_001_01C6DCC6.A1127019
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText30054 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>Hi,</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Following text is from =
"/usr/local/linux/Doumentation/dev-interface":</FONT></DIV>=0A=
<DIV><FONT face=3DArial =
size=3D2>----------------------------------------------------------------=
------------------------------------------------------------------</FONT>=
</DIV>=0A=
<DIV>You can do SMBus level transactions (see documentation file =
smbus-protocol<BR>for details) through the following =
functions:<BR>&nbsp; __s32 i2c_smbus_write_quick(int file, __u8 =
value);<BR>&nbsp; __s32 i2c_smbus_read_byte(int file);<BR>&nbsp; __s32 =
i2c_smbus_write_byte(int file, __u8 value);<BR>&nbsp; __s32 =
i2c_smbus_read_byte_data(int file, __u8 command);<BR>&nbsp; __s32 =
i2c_smbus_write_byte_data(int file, __u8 command, __u8 value);<BR>&nbsp; =
__s32 i2c_smbus_read_word_data(int file, __u8 command);<BR>&nbsp; __s32 =
i2c_smbus_write_word_data(int file, __u8 command, __u16 =
value);<BR>&nbsp; __s32 i2c_smbus_process_call(int file, __u8 command, =
__u16 value);<BR>&nbsp; __s32 i2c_smbus_read_block_data(int file, __u8 =
command, __u8 *values);<BR>&nbsp; __s32 i2c_smbus_write_block_data(int =
file, __u8 command, __u8 =
length,<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
__u8 *values);</DIV>=0A=
<DIV>--------------------------------------------------------------------=
-------------------</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>I searched in the 2.6.13 version of Timesys and Suse linux, but I =
didn't find definition or declaration in file =
'/usr/include/linux/i2c-dev.h' and '/usr/include/linux/i2c.h'.</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Am I missing any information about the location of the above =
functions?</DIV>=0A=
<DIV>Do I need to implement the above functions?</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Thanks and Regards,</DIV>=0A=
<DIV>Sachin Rane</DIV>=0A=
<DIV>&nbsp;</DIV></DIV></BODY></HTML>
------_=_NextPart_001_01C6DCC6.A1127019--
