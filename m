Return-Path: <charanya.venkatraman@gmail.com>
Message-ID: <fa84b3da0708290938l40d8f543oc0e34fa9bea806a4@mail.gmail.com>
Date: Wed, 29 Aug 2007 22:08:01 +0530
From: "charanya venkatraman" <charanya.venkatraman@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Subject: 2.6 kernel hangs after loading device tree
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_2018_31310481.1188405481450"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_2018_31310481.1188405481450
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all
       Sorry about the previous mail.Got sent  by mistake.

Iam using the 2.6.22.5 kernel on MPC 8560 and MPC8540 on my custom
board.Mykernel hangs after loading the device tree in both the
processors .There is
no output on the serial port after loading the device tree.Am using U-boot
1.2.0 as the bootloader.After enabling debug in u-boot i could see that the
control is getting transferred to the kernel after which it hangs.Earlier i
tried using 2.6.21 which also hangs at the same point.The config files used
were MPC8540ADS_defconfig and MPC8560ADS_defconfig under powerpc directory.
The changes that were made to the device tree are:
1.The reg and ranges properties of the soc node have been changed to account
for the change in CCSRBAR of my board.
2.Removed the PCI,mdio nodes and ethernet nodes since i dont need support
for these as of now.

I have tried the following console arguments:
MPC8540: bootargs root=/dev/ram rw console=ttyS0,115200
MPC8560:bootargs root=/dev/ram rw console=ttyCPM0,115200

Any help on this issue??

Thanks.
Charanya.

------=_Part_2018_31310481.1188405481450
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sorry about the previous mail.Got sent&nbsp; by mistake.<br><br>Iam using the <a href="http://2.6.22.5">2.6.22.5</a> kernel on MPC 8560 and MPC8540 on my custom board.My kernel hangs after loading the device tree in both the processors .There is no output on the serial port after loading the device 
tree.Am using U-boot 1.2.0 as the bootloader.After enabling debug in u-boot i could see that the control is getting transferred to the kernel after which it hangs.Earlier i tried using 2.6.21 which also hangs at the same 
point.The config files used were MPC8540ADS_defconfig and MPC8560ADS_defconfig under powerpc directory.<br>The changes that were made to the device tree are:<br>1.The reg and ranges properties of the soc node have been changed to account for the change in CCSRBAR of my board.
<br>2.Removed the PCI,mdio nodes and ethernet nodes since i dont need support for these as of now.<br><br>I have tried the following console arguments:<br>MPC8540: bootargs root=/dev/ram rw console=ttyS0,115200<br>MPC8560:bootargs root=/dev/ram rw console=ttyCPM0,115200
<br><br>Any help on this issue??<br><br>Thanks.<br>Charanya.<br><br><br>

------=_Part_2018_31310481.1188405481450--
