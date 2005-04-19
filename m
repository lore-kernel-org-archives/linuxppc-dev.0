Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 1A9C267A33
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 04:27:33 +1000 (EST)
Message-ID: <42654D8F.8010902@mvista.com>
Date: Tue, 19 Apr 2005 11:27:27 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Sam Song <samlinuxppc@yahoo.com.cn>
References: <20050419135257.50676.qmail@web15805.mail.cnb.yahoo.com>
In-Reply-To: <20050419135257.50676.qmail@web15805.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 824x Sandpoint with 2.6.x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sam Song wrote:

> <snip>
>
>
>OK, I am now up to the joint of early_console and
>normal console. Switch problem. Perhaps I miss sth
>or what?
>
><snip>
>
>
>Kernel command line:
>console=uart,mmio,0xfdfce500,115200n8
>console=ttyS0,115200
>root=/dev/ram rw ramdisk_size=200000
>ip=192.168.0.3:192.168..2:::sandpoint:et
>h0:off panic=1
>
<snip>

Get rid of the "console=uart,mmio,0xfdfce500,115200n8" part of the
cmdline and see what happens (keep the "console=ttyS0,115200" part).


Mark
