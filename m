Return-Path: <cmunoz@sablenetworks.com>
Received: from nm5-vm0.bullet.mail.bf1.yahoo.com
	(nm5-vm0.bullet.mail.bf1.yahoo.com [98.139.213.150])
	by ozlabs.org (Postfix) with SMTP id 3B017B6F68
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Sep 2011 03:27:09 +1000 (EST)
Subject: Re: Loading Linux from already running code..
From: Carlos Munoz <cmunoz@sablenetworks.com>
To: Sumesh Kaana <sumeshkkn@hotmail.com>
In-Reply-To: <BLU124-W1648A42F7514E880C9B199B4F20@phx.gbl>
References: <BLU124-W1648A42F7514E880C9B199B4F20@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 10:26:56 -0700
Message-ID: <1317058016.1650.50.camel@pug>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

You could build a tarball containing the root files system, dtb, Linux,
plus a header indicating where the different pieces need to be loaded.
Then your initial code loads the different parts at the right memory
locations, sets up the Linux arguments, and jumps to Linux.

-Carlos

On Sun, 2011-09-25 at 18:47 +0000, Sumesh Kaana wrote:
> Hi All,
> 
> 
> I need some suggestions for booting Linux( >2.6.30 ) with my new
> project.
> 
> 
> Scenario:
> I've a custom built board with PowerPC 440 + 256 MB RAM. there is NO
> FLASH on this board.
> There is a hardware logic which will get an initial piece of
> code (through hardware network) into the ram and then execute it. This
> code does mandatory initialization of a proprietary chip and this code
> MUST execute on power on. any other images (Linux image or ramdisk)
> can be loaded any specified area in the memory along with this code.
> 
> 
> My requirement is to boot Linux at the end of the this initialization.
> 
> 
> what is the best way to do it? 
> 
> 
> 1. Will it be possible to transfer control to a
> simpleImage.initrd.myboard.elf(or .bin ..?!)  image from
> already_existing_code?
> 2. Should I use u-boot and then load uImage, ramdisk and the dts blob?
> Using u-boot will reduce the effort?
> 3. Is there any other way to approach this??
> 
> 
> 
> 
> 
> 
> Regards,
> Sumesh
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
