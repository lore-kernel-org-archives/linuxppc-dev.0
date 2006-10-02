Return-Path: <ammubhai@gmail.com>
Message-ID: <4520E46B.6040509@gmail.com>
Date: Mon, 02 Oct 2006 11:05:31 +0100
From: Ameet Patil <ammubhai@gmail.com>
MIME-Version: 1.0
To: christophe.alayrac@univ-orleans.fr
Subject: Re: ML403 patch for UBOOT
References: <1159183304.11649.17.camel@Serge-Linux>	
	<4520CADB.4020004@gmail.com> <1159781316.8645.27.camel@Serge-Linux>
In-Reply-To: <1159781316.8645.27.camel@Serge-Linux>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

alayrac wrote:
> Hi Ameet,
>
> Thanks for your reply
>   
>> you got the URL wrong. Its http://linux.get2knowmore.com
>>     
> I've got the right address but I've made an error in the email.
>
> Following your instrcutions I've succeed to run the 2.6.17.1 kernel on
> my ML403 board. The process stop when I try to mount the NFS root file
> system. This is because there is no Etehrnet drivers.
>
> It seems that Xilinx will release SP2 for EDK 8.2 very soon and that
> issue should be solved.
>
> We decide to work on u-boot on that ML403 board (and linux 2.4.26 very
> well documented on byu web site, link on your web page) . To do so I use
> ML403 ppc ref design and I've dowloaded the u-boot.zip from xilinx
> website.
>
> This u-boot.zip have empty files for sw_services (tcl script...), and
> I've noticed that memory map found in u-boot/board/ml403/xparameters.h
> did not match the one of the design from Xilinx.
>
> I've then modify the address in this file and I succesfully start U-boot
> on that board.
>
> Unfortunately, the process stop on the last line of do_boot_linux when
> whe are supposed to get back to entry point at address 0x00000000.
> (the uImage is properly unzip, and CRC OK).
>
> I did not know why the process stop?
> Do you think it has something to do with the hardware design?
> Should I modify the mapping of the hardware to macth the original memory
> map of the xparameters.h that comes with this u-boot.zip file?
> (that is the next track I'm working on).
>
> I did not found PartII on your web site, it is an error from me or you
> did not find time to publish it?
>
> Thanks any way for your contribution and your help.
>
> Kinds Regards
>
> Chris
>
>
>
>
>   
Hi Chris,
    I donot use U-boot. So no idea...can't help there... sorry.
About Part II: Its a work in progress... :-) will publish soon!

-Ameet
