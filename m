Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.193])
	by ozlabs.org (Postfix) with ESMTP id EE12067BB4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Sep 2006 07:08:32 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so409296nzh
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 14:08:30 -0700 (PDT)
Message-ID: <198592450609291408w2dbf7e5ckf5e4cf7023d2000@mail.gmail.com>
Date: Fri, 29 Sep 2006 21:08:30 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Need help on PPC8343E bringup
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_12347_11481335.1159564110522"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_12347_11481335.1159564110522
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello linux-ppc experts,

I'm trying to use using wind river jtag probe to download uboot to our
switching box which is with PPC8343E/Intel 28F128J3D memory flash(16M).
Memory mapping is starting from 0xFF000000 to 0xFFFFFFFF which is 16M. The
JTAG software I'm using is visionclick8.

The problem now is that I even couldn't erash flash, with following error
message:

TF ERASE FFF00000..FFFFFFFF INTEL  28F128Jx ( 8192 x 16 )  1 Device
Erasing Flash(s) ... Failed
!ERROR! - [msg100000] Failed while erasing the device(s)
>BKM>
!HALT! - [msg90009] Target Stopped : CheckStop taken; PC = 0x00007404 [EVENT
Taken]
>BKM>

Does anyone has experiece to bring up this CPU, and could shed some lights
on it? Thank you in advance.

- Reeve

------=_Part_12347_11481335.1159564110522
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello linux-ppc experts,<br>
<br>
I'm trying to use using wind river jtag probe to download uboot to our
switching box which is with PPC8343E/Intel 28F128J3D memory flash(16M).
Memory mapping is starting from 0xFF000000 to 0xFFFFFFFF which is 16M.
The JTAG software I'm using is visionclick8. <br>
<br>
The problem now is that I even couldn't erash flash, with following error message:<br>
<br>
TF ERASE FFF00000..FFFFFFFF INTEL&nbsp; 28F128Jx ( 8192 x 16 )&nbsp; 1 Device <br>
Erasing Flash(s) ... Failed<br>
!ERROR! - [msg100000] Failed while erasing the device(s) <br>
&gt;BKM&gt;<br>
!HALT! - [msg90009] Target Stopped : CheckStop taken; PC = 0x00007404 [EVENT Taken]<br>
&gt;BKM&gt;<br>
<br>
Does anyone has experiece to bring up this CPU, and could shed some lights on it? Thank you in advance.<br>
<br>
- Reeve<br>

------=_Part_12347_11481335.1159564110522--
