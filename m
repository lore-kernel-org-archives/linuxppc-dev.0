Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D715BDDE11
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 01:49:49 +1000 (EST)
Date: Mon, 4 May 2009 17:49:37 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Need a patch tested on a windtunnel powermac
Message-ID: <20090504174937.233cb127@hyperion.delvare>
In-Reply-To: <20090504154208.GC14017@zod.rchland.ibm.com>
References: <18936.58163.872136.772820@cargo.ozlabs.ibm.com>
	<20090430002448.GA5208@hansolo.jdub.homelinux.org>
	<20090430191707.GB2424@yoda.jdub.homelinux.org>
	<20090504145232.GB14017@zod.rchland.ibm.com>
	<20090504174001.5429769b@hyperion.delvare>
	<20090504154208.GC14017@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 May 2009 11:42:08 -0400, Josh Boyer wrote:
> On Mon, May 04, 2009 at 05:40:01PM +0200, Jean Delvare wrote:
> >For completeness, as I see you built the driver as a module, could you
> >try unloading and reloading it?
> 
> Sure:
> 
> [jwboyer@localhost macintosh]$ sudo rmmod therm_windtunnel
> [jwboyer@localhost macintosh]$ sudo modprobe therm_windtunnel
> [jwboyer@localhost macintosh]$ dmesg
> <snip>
> DS1775 digital thermometer [@49]
> Temp: 53.6 C  Hyst: 60.0 C  OS: 65.0 C
> ADM1030 fan controller [@2c]
> CPU-temp: 53.6 C, Case: 31.8 C,  Fan: 0 (tuned -11)
> 
> Seems to work fine.

Excellent. Thanks again!

-- 
Jean Delvare
