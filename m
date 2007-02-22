Return-Path: <juergen.beisert@weihenstephan.org>
Received: from bill.weihenstephan.org (bill.weihenstephan.org [82.135.35.21])
	by ozlabs.org (Postfix) with ESMTP id CC836DDE21
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Feb 2007 21:28:08 +1100 (EST)
From: Juergen Beisert <juergen.beisert@weihenstephan.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: jffs2 file system
Date: Thu, 22 Feb 2007 11:27:56 +0100
References: <9097247.post@talk.nabble.com>
In-Reply-To: <9097247.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200702221128.02970.juergen.beisert@weihenstephan.org>
Cc: Nethra <nethra_gmit@yahoo.co.in>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

MTD partitions and partition commandline are enabled:

> CONFIG_MTD_PARTITIONS=y
> # CONFIG_MTD_REDBOOT_PARTS is not set
> CONFIG_MTD_CMDLINE_PARTS=y
[...]
>
> on evaluation (PQ2FADS-ZU) board....
> --------------------------------------------
> setenv ipaddr 192.168.178.234
> setenv serverip 192.168.178.110
> setenv ethaddr 00:99:23:44:ad:de
> setenv bootcmd 'tftpboot 0x1000000 jffsenabled\;bootm 0x1000000\;'
> setenv bootargs root=/dev/mtdblock0 rootfstype=jffs2
> ip=192.168.174.231:192.168.178.110:192.168.174.47:255.255.255.0:cashel:eth1
>:off

But where is your commandline that describes the partitions in your flash?

Juergen
