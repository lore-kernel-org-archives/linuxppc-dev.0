Return-Path: <msm@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 0D4E667B9E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Sep 2006 02:50:03 +1000 (EST)
Subject: Re: How to move from /ppc/ to /powerpc/
From: Matthew McClintock <msm@freescale.com>
To: Fredrik Roubert <roubert@df.lth.se>
In-Reply-To: <20060921160808.GB4828@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
	<20060912105830.3923d537.kim.phillips@freescale.com>
	<20060913132817.GD18263@igloo.df.lth.se>
	<20060921160808.GB4828@igloo.df.lth.se>
Content-Type: text/plain
Date: Mon, 25 Sep 2006 11:49:51 -0500
Message-Id: <1159202991.5485.0.camel@localhost>
Mime-Version: 1.0
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

On Thu, 2006-09-21 at 18:08 +0200, Fredrik Roubert wrote:
>         chosen {
>                 name = "chosen";
>                 linux,platform = <00000600>;
>                 linux,stdout-path = "/soc8349@ff400000/serial@4500";
>                 bootargs = "root=/dev/nfs rw
> nfsroot=150.158.215.227:/home/rootfs/dev-ds
> ip=150.158.211.83:150.158.215.227:150.158.212.1:255.255.248.0:dev-ds:eth0:off console=ttyS0,115200 console=ttyS0,115200 rtc-x1205.force=0,0x6f";
>         };
> 

Fredrik,

It looks like you already have your chosen node in your DTS file. With
my u-boot patches the appropriate chosen node is added to the flat tree
based off the u-boot environment.

-Matthew
