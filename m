Return-Path: <Shengping.Liu@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 0526EDDE20
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Sep 2007 23:23:41 +1000 (EST)
Message-ID: <46EF93D8.6050201@windriver.com>
Date: Tue, 18 Sep 2007 17:01:12 +0800
From: Andrew Liu <shengping.liu@windriver.com>
MIME-Version: 1.0
To: Mustafa Cayir <mustafa.cayir@bte.mam.gov.tr>
Subject: Re: Problem booting linux with device tree table
References: <7B9A8FF57DBB524190E98CABF6E56F070B9298@itri.bte.mam.gov.tr>
In-Reply-To: <7B9A8FF57DBB524190E98CABF6E56F070B9298@itri.bte.mam.gov.tr>
Content-Type: multipart/mixed; boundary="------------060604090100030400030904"
Cc: linuxppc-embedded@ozlabs.org
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
--------------060604090100030400030904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Latest U-boot need a chosen node in your DTS  file, So u need to add a
chosen node in your DTS file.

Take mpc8272ads for example: in its DTS, has the following:

        chosen {
                name = "chosen";
                linux,platform = <0>;
                interrupt-controller = <&Cpm_pic>;
        };


BRs,
Andrew
Mustafa Cayir wrote:
>
> Hi all,
>
> I am trying to boot TQM5200 with linux 2.6 kernel. i am using latest
> version of linux and u-boot from denx. And compiled with ELDK4.1
>
> i use dtc compiler with following command:
> dtc -O dtb -o tqm5200.dtb -b 0 tqm5200.dts
>
> Booting process gives following error and reset the board.
>
> WARNING: could not create /chosen FDT_ERR_NOSPACE.
> ERROR: /chosen node create failed - must RESET the board to recover.
>
> Regards.
>
>
>
> Using FEC ETHERNET device
> TFTP from server 10.18.2.83; our IP address is 10.18.5.44
> Filename 'uImage'.
> Load address: 0x200000
> Loading: #################################################################
>          ####################################
> done
> Bytes transferred = 1473038 (167a0e hex)
> Using FEC ETHERNET device
> TFTP from server 10.18.2.83; our IP address is 10.18.5.44
> Filename 'tqm5200.dtb'.
> Load address: 0x400000
> Loading: #
> done
> Bytes transferred = 3816 (ee8 hex)
> ## Booting image at 00200000 ...
>    Image Name:   Linux-2.6.23-rc6-gf695e369
>    Created:      2007-09-19   1:31:43 UTC
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1472974 Bytes =  1.4 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Booting using the fdt at 0x400000
> WARNING: could not create /chosen FDT_ERR_NOSPACE.
> ERROR: /chosen node create failed - must RESET the board to recover.
>
>
>
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--------------060604090100030400030904
Content-Type: text/x-vcard; charset=utf-8;
 name="shengping.liu.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="shengping.liu.vcf"

begin:vcard
fn:Andrew Liu
n:;Andrew Liu
org:China Development Center;Engineering
adr:;;Wangjing Zhonghuan Nanlu No.9 Wangjing Plaza Tower B 15F Chaoyang District Beijing China;Beijing;;100102;China
email;internet:shengping.liu@windriver.com
tel;work:86-10-8477-8639
tel;fax:86-10-6479-0367
tel;cell:86-13717751687
url:http://twiki.wrs.com/do/view/Main/AndrewLiu
version:2.1
end:vcard


--------------060604090100030400030904--
