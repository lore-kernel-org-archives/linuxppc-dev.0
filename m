Return-Path: <jepmalinux@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 109E5DDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Dec 2007 08:27:09 +1100 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3596055pyi.0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Dec 2007 13:27:08 -0800 (PST)
Message-ID: <ef1737dc0712241327t3cc7c14kcb91e9a4e550df18@mail.gmail.com>
Date: Mon, 24 Dec 2007 22:27:08 +0100
From: "Josep Maria Batlle" <jepmalinux@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: i2c device for a linux 2.6 in XUPV2P
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6005_17063389.1198531628049"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_6005_17063389.1198531628049
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

I have booted up linux 2.6 on Xilinx XUPV2P (using the base of ml300 config
file).
Now I am trying to use the i2c in the user-space. First of all: is it
possible?

My first attempts have not worked. I have made this:
1) I enable "I2C Support" and "I2C device interface" in the kernel
recompilation.
2) I added the "i2c-0" device in /dev (# mknod i2c-0 c 89 0)
3) then I run a simple program to open the device (provided by the
"dev-interface" file of i2c kernel documentation) that returns this errno
message: "No such device".

I have tried to use the device number 1, 2, 3, 4 but these have not worked.
I have tried to use the device "i2cn" but not worked. I have tried to use
all the BSP's from the EDK (7.1i) and then only the "xparameters_ml300.h" in
the compilation. After all of this, now I am modifying the RFS for "mdev"...
Somebody can tell me what I am doing wrong if this use is possible?

I use the kernel tree "virtex-for-2.6.24" from SecretLab and Busybox 1.7.2.

Thanks.

------=_Part_6005_17063389.1198531628049
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,<br><br>I have booted up linux 2.6 on Xilinx XUPV2P (using the base of ml300 config file).<br>Now I am trying to use the i2c in the user-space. First of all: is it possible?<br><br>My first attempts have not worked. I have made this:
<br>1) I enable &quot;I2C Support&quot; and &quot;I2C device interface&quot; in the kernel recompilation.<br>2) I added the &quot;i2c-0&quot; device in /dev (# mknod i2c-0 c 89 0)<br>3) then I run a simple program to open the device (provided by the &quot;dev-interface&quot; file of i2c kernel documentation) that returns this errno message: &quot;No such device&quot;.
<br><br>I have tried to use the device number 1, 2, 3, 4 but these have not worked. I have tried to use the device &quot;i2cn&quot; but not worked. I have tried to use all the BSP&#39;s from the EDK (7.1i) and then only the &quot;xparameters_ml300.h&quot; in the compilation. After all of this, now I am modifying the RFS for &quot;mdev&quot;...
<br>Somebody can tell me what I am doing wrong if this use is possible?<br><br>I use the kernel tree &quot;virtex-for-2.6.24&quot; from SecretLab and Busybox 1.7.2.<br><br>Thanks.<br>

------=_Part_6005_17063389.1198531628049--
