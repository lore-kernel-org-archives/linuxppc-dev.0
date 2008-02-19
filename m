Return-Path: <m.louvel@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.226])
	by ozlabs.org (Postfix) with ESMTP id 1B8D5DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 22:59:03 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2200540wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 03:59:02 -0800 (PST)
Message-ID: <dda529d0802190359r526dc959y8117185e1834e9f4@mail.gmail.com>
Date: Tue, 19 Feb 2008 11:59:01 +0000
From: "maxime louvel" <m.louvel@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: 2.6.24 for mpc8458amc
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8812_28100716.1203422341839"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_8812_28100716.1203422341839
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am trying to make a 2.6.24 vanilla kernel boot (an work fine in a second
time) on a mpc8548amc board.
I have add the platform specific stuff from the sources of the current
kernel running on the cards.
What I have basically add is:
- a folder mpc8548amc, in the config/platform directory, which allow to
select the mpc8548amc as the supported platform
- add the following files:
  - arch/ppc/configs/mpc8548amc_defconfig
  - arch/ppc/configs/platforms/85xx/mpc_8548_amc.h and .c
- I have used the dts of an another platform (mpc8548cds) which seems quite
the same, but I haven't got any confirmation of that yet.

When I am booting the kernel image I get:

AMC=> dhcp 0x1000000 uImage.amc.2.6.24
Speed: 1000, full duplex
BOOTP broadcast 1
DHCP client bound to address 10.255.255.2
Using eTSEC0 device
TFTP from server 0.0.0.0; our IP address is 10.255.255.2; sending through
gateway 10.1.1.1
Filename 'uImage.amc.2.6.24'.
Load address: 0x1000000
Loading: #################################################################
        #################################################################
        #################################################################
        #################################################################
        #################################################################
        ###########################
done
Bytes transferred = 1802102 (1b7f76 hex)
AMC=> bootm 0x1000000
## Booting image at 01000000 ...
  Image Name:   Linux-2.6.24
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    1802038 Bytes =  1.7 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK

No further messages...

Does someone has an idea ?

thanks,
Maxime


-- 
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom

------=_Part_8812_28100716.1203422341839
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I am trying to make a 2.6.24 vanilla kernel boot (an work fine in a second time) on a mpc8548amc board.<br>I
have add the platform
specific stuff from the sources of the current kernel running on the
cards.<br>



What I have basically add is:<br>- a folder mpc8548amc,
in the config/platform directory, which allow to select the mpc8548amc
as the supported platform <br>- add the following files:<br>



&nbsp; - arch/ppc/configs/mpc8548amc_defconfig<br><div>&nbsp; - arch/ppc/configs/platforms/85xx/mpc_8548_amc.h and .c<br>-
I have used the dts of an another platform (mpc8548cds) which seems
quite the same, but I haven&#39;t got any confirmation of that yet.<br>



<br>When I am booting the kernel image I get:<br><br>AMC=&gt; dhcp 0x1000000 uImage.amc.2.6.24<br>Speed: 1000, full duplex<br>BOOTP broadcast 1<br>DHCP client bound to address <a href="http://10.255.255.2/" target="_blank">10.255.255.2</a><br>





Using eTSEC0 device<br>TFTP from server <a href="http://0.0.0.0/" target="_blank">0.0.0.0</a>; our IP address is <a href="http://10.255.255.2/" target="_blank">10.255.255.2</a>; sending through gateway <a href="http://10.1.1.1/" target="_blank">10.1.1.1</a><br>





Filename &#39;uImage.amc.2.6.24&#39;.<br>Load address: 0x1000000<br>Loading: ##############################<div>###################################<br> &nbsp; &nbsp; &nbsp; &nbsp; #################################################################<br>





 &nbsp; &nbsp; &nbsp; &nbsp; #################################################################<br> &nbsp; &nbsp; &nbsp; &nbsp; #################################################################<br> &nbsp; &nbsp; &nbsp; &nbsp; #################################################################<br>





 &nbsp; &nbsp; &nbsp; &nbsp; ###########################<br>done<br>Bytes transferred = 1802102 (1b7f76 hex)<br>AMC=&gt; bootm 0x1000000<br>## Booting image at 01000000 ...<br> &nbsp; Image Name: &nbsp; Linux-2.6.24<br> &nbsp; Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>





 &nbsp; Data Size: &nbsp; &nbsp;1802038 Bytes = &nbsp;1.7 MB<br> &nbsp; Load Address: 00000000<br> &nbsp; Entry Point: &nbsp;00000000<br> &nbsp; Verifying Checksum ... OK<br> &nbsp; Uncompressing Kernel Image ... OK<br><br>No further messages...</div><br>Does someone has an idea ?<br>





<br>thanks,<br>Maxime</div><br clear="all"><br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom

------=_Part_8812_28100716.1203422341839--
