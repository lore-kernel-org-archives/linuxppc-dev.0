Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 7B59FDDEDF
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 23:06:08 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LkcJv-0008Bk-6r
	for linuxppc-dev@ozlabs.org; Fri, 20 Mar 2009 10:51:23 +0000
Received: from p4ff0427b.dip.t-dialin.net ([79.240.66.123])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 10:51:23 +0000
Received: from dzu by p4ff0427b.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 10:51:23 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Problem with radeonfb on PowerPC 7448&MV64560
Date: Fri, 20 Mar 2009 11:51:11 +0100
Message-ID: <m2bprw79i8.fsf@ohwell.denx.de>
References: <200903171630.25340.edfuchs@uni-kassel.de>
	<1237331100.25062.166.camel@pasglop>
	<200903191051.37875.edfuchs__31387.3780928136$1237456433$gmane$org@uni-kassel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Eduard,

> Am Mittwoch 18 März 2009 00:05:00 schrieb Benjamin Herrenschmidt:
>> On Tue, 2009-03-17 at 16:30 +0100, Eduard Fuchs wrote:
>> > Hi all,
>> >
>> > since several days I'm trying to run an ATI 9250 (PCI) graphic card under
>> > Linux Kernel 2.6.27.19. Nevertheless without success. The kernel shows
>> > the following message:
>> >
>> > videoboot: Booting PCI video card bus 0, function 0, device 7
>> > biosEmu: undefined interrupt 15h called!
>> > biosEmu/bios.int42: unknown function AH=0x0, AL=0x7, BL=0x0
>>
>> The above comes from some patches you added to the kernel ? You should
>> probably do the softboot in the firmware instead...
>
> Yes. I'm using the videoboot-2.6x.patch (this patch contain also the xf86emu 
> from www.scitechsoft.com). With this pach the radeon card work properly with 
> 2.6.12 kernel version. On the 2.6.27 kernel the "videoboot" fetch the bios 
> from the video card and start them in the xf86emu.
>
> Can I initialize the video card in uboot too?

Yes, indeed you can.  In a recent version of U-Boot, search for
'CONFIG_BIOSEMU' in include/configs/*.  We tested this on a sequoia
board, so include/configs/sequoia.h should be a good start for this.

Cheers
  Detlev

--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
