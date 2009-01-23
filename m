Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id A7CCCDDF9E
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 02:27:33 +1100 (EST)
Message-ID: <4979E1E4.8090807@matrix-vision.de>
Date: Fri, 23 Jan 2009 16:27:32 +0100
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Wolfgang Wegner <wolfgang@leila.ping.de>
Subject: Re: MicroSD (SPI mode) support in Linux-2.6.26-1
References: <dd2f3b320901221959w956ccc6r3b700633acbefd3a@mail.gmail.com>
	<4979BB83.5060506@matrix-vision.de>
	<20090123134001.GR2004@leila.ping.de>
In-Reply-To: <20090123134001.GR2004@leila.ping.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Wegner wrote:
> Hi Andre,
>
> On Fri, Jan 23, 2009 at 01:43:47PM +0100, Andre Schwarz wrote:
>   
>> Sai Amruta wrote:
>>     
>>> Hi All,
>>>
>>> I am using linux-2.6.26 on MPC8567 and microSD is connected through 
>>> SPI interface.
>>> Is the existing mmc driver supports microSD?
>>>       
>> yes - it's working perfectly fine on my MPC8343.
>> Even with SDHC cards ;-)
>>     
>
> that's great to hear - is there anything like a HOWTO on how to set
> this up on top of the SPI driver (probably involving some custom GPIO
> stuff for card and WP detection) out there?
> I tried to but did not get it to work on MCF53xx (uClinux 2.6.23-uc0)
> and probably did not find the right search strings either.
>
> Regards,
> Wolfgang
>
>   
Wolfgang,

of course I forgot the most important messages ... ;-)


mvBL-M7> insmod /modules/mmc_spi.ko
mvBL-M7> dmesg -c
mmc_spi spi28672.0: SD/MMC host mmc0, no DMA, no WP, no poweroff
mmc0: host does not support reading read-only switch. assuming write-enable.
mmc0: new SD card on SPI
mmcblk0: mmc0:0000 SD02G 1921024KiB
 mmcblk0: p1
mvBL-M7> mount /mnt/mmc/
mvBL-M7> ls /mnt/mmc/
TestApp.JPG                       do
TestCSharpApp.exe                 mvBlueCOUGAR.msi
autostart                         mvPPC_6XX-NAND-20081010-0946.tgz
distribution.zip                  uInitrd.mvblm7_nova
mvBL-M7>



cheers,
Andre

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner, Hans-Joachim Reich
