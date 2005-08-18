Return-Path: <vijesh.vh@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.199])
	by ozlabs.org (Postfix) with ESMTP id 483BC67FED
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 21:13:14 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i11so330275wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 04:13:13 -0700 (PDT)
Message-ID: <8e78982e050818040710e8c316@mail.gmail.com>
Date: Thu, 18 Aug 2005 16:37:05 +0530
From: Vijesh VH <vijesh.vh@gmail.com>
To: rmk@arm.linux.org.uk, greg@censoft.com, linuxppc-embedded@ozlabs.org,
	Linus.Torvalds@helsinki.fi
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5045_33323186.1124363225545"
Subject: Regarding Keyboard events mapping in different consoles
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_5045_33323186.1124363225545
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
I am currently working on Powerpc405 Processor. Here I have two interfaces=
=20
like serial Interface and IR Interface.
When I boot the kernel using the Serial console what ever i type from the=
=20
keyboard(on a PC) using minicom the serial data transfer takes place in=20
kernel , the kernel decodes the key events of serial console( serial=20
interface).=20
Now, I have built the IR Driver which access the handle_scancode function i=
n=20
the kernel (keyboard.c) by passing the required scan codes and status of th=
e=20
keys.
The problem here is What ever i type using IR Keyboard appears on my VC=20
(virtual console or Frame buffer Device) . How do I make IR key=20
events(handle_scancode) to be handled by the Serial console's keyboard part=
.

Please do guide me how to proceed.


--=20
Thanks and Regards,
Vijesh V H

------=_Part_5045_33323186.1124363225545
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,<br>
&nbsp;I am currently working on Powerpc405 Processor. Here I have two inter=
faces like serial Interface and IR Interface.<br>
When I boot the kernel using the Serial console what ever i type from
the keyboard(on a PC) using minicom the serial data transfer takes
place in kernel , the kernel decodes the key events of serial console(
serial interface). <br>
&nbsp;Now, I have built the IR Driver which access the handle_scancode
function in the kernel (keyboard.c) by passing the required scan codes
and status of the keys.<br>
&nbsp;The problem here is What ever i type using IR Keyboard appears on
my VC (virtual console or&nbsp; Frame buffer Device) . How do I make IR
key events(handle_scancode) to be handled by the Serial console's
keyboard part.<br>
<br>
Please do guide me how to proceed.<br>
<br clear=3D"all"><br>-- <br>Thanks and Regards,<br>Vijesh V H=20

------=_Part_5045_33323186.1124363225545--
