Return-Path: <SRane@alphion.com>
Received: from alphion.com (unknown [66.147.184.82])
	by ozlabs.org (Postfix) with ESMTP id 5D67C67A39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Sep 2006 22:51:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C6DCB3.72C43109"
Subject: I2C: Getting Compiation Error for application program
Date: Wed, 20 Sep 2006 08:51:10 -0400
Message-ID: <8584FDC94AFF7640B17B8A89B23B19B34F6571@sbsserver.AlphionCorp.local>
From: "Sachin Rane" <SRane@alphion.com>
To: <linux-users-list@lists.timesys.com>
Cc: i2c@lm-sensors.org, linuxppc-embedded@ozlabs.org
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

------_=_NextPart_001_01C6DCB3.72C43109
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am trying to compile simple program (appended), but getting lots of =
compilation error.
I am using Timesys Linux 2.6.13 for ppc440 evaluation board.=20
=20
Command used for compilation:
$> gcc eeprom-client.c -o eeprom-client.o
=20
Could you help me to find out the reason behind getting the errors?
=20
Regards,
Sachin Rane
=20
=20
8< ------------------------eeprom-client.c =
-------------------------------------------------------------------------=
------------
=20
#include <linux/i2c.h>
#include <linux/i2c-dev.h>

int main()
{
     int file;
     int adapter_nr =3D 0; /* probably dynamically determined */
     char filename[20];
     int addr =3D 0xA1; /* The I2C address */

    sprintf(filename,"/dev/i2c-%d",adapter_nr);
    if ((file =3D open(filename,O_RDWR)) < 0)
   {
       exit(1);
    }
  =20
    if (ioctl(file,I2C_SLAVE,addr) < 0)
   {
      exit(1);
   }
   else
  {
      printf("\n Able to bind the adapter");
   }
   return 0;
}

8< =
-------------------------------------------------------------------------=
------------------------------------

------_=_NextPart_001_01C6DCB3.72C43109
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<HTML dir=3Dltr><HEAD>=0A=
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dunicode">=0A=
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR></HEAD>=0A=
<BODY>=0A=
<DIV><FONT face=3DArial color=3D#000000 size=3D2>Hi,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I am trying to compile&nbsp;simple =
program (appended), but getting lots of compilation error.</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>I am using Timesys Linux 2.6.13 for =
ppc440 evaluation board.&nbsp;</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Command used for =
compilation:</FONT></DIV>=0A=
<DIV>$&gt;&nbsp;gcc eeprom-client.c -o eeprom-client.o</DIV>=0A=
<DIV>&nbsp;</DIV>=0A=
<DIV>Could you help me to find out the reason behind getting the =
errors?</DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Regards,</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>Sachin Rane</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV><FONT face=3DArial size=3D2>8&lt; ------------------------<FONT =
face=3D"Times New Roman" size=3D3>eeprom-client.c</FONT> =
-------------------------------------------------------------------------=
------------</FONT></DIV>=0A=
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV>#include &lt;linux/i2c.h&gt;<BR>#include =
&lt;linux/i2c-dev.h&gt;<BR><BR>int main()<BR>{</DIV>=0A=
<DIV>&nbsp;&nbsp;&nbsp;&nbsp; int file;<BR>&nbsp;&nbsp;&nbsp;&nbsp; int =
adapter_nr =3D 0; /* probably dynamically determined */<BR>&nbsp; =
&nbsp;&nbsp; char filename[20];</DIV>=0A=
<DIV>&nbsp;&nbsp;&nbsp; &nbsp;int addr =3D 0xA1; /* The I2C address =
*/<BR></DIV>=0A=
<DIV>&nbsp;&nbsp;&nbsp; =
sprintf(filename,"/dev/i2c-%d",adapter_nr);<BR>&nbsp; &nbsp; if ((file =
=3D open(filename,O_RDWR)) &lt; 0)<BR>&nbsp;&nbsp; =
{<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exit(1);<BR>&nbsp;&nbsp;&nbsp; =
}</DIV>=0A=
<DIV>&nbsp;&nbsp; </DIV>=0A=
<DIV>&nbsp;&nbsp;&nbsp; if (ioctl(file,I2C_SLAVE,addr) &lt; =
0)<BR>&nbsp;&nbsp; {<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
exit(1);<BR>&nbsp;&nbsp; }</DIV>=0A=
<DIV>&nbsp;&nbsp; else<BR>&nbsp; {<BR>&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;printf("\n Able to bind the adapter");<BR>&nbsp;&nbsp; =
}<BR>&nbsp;&nbsp; return 0;<BR>}<BR></DIV>=0A=
<DIV><FONT face=3DArial size=3D2>8&lt; =
-------------------------------------------------------------------------=
------------------------------------</FONT></DIV></BODY></HTML>
------_=_NextPart_001_01C6DCB3.72C43109--
