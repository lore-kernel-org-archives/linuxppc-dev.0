Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id B93AA67B8C
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Feb 2006 06:31:27 +1100 (EST)
Subject: Re: [Alsa-devel] Re: [PPC,SOUND] Fix audio gpio state detection
From: Lee Revell <rlrevell@joe-job.com>
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060226173908.GA4871@suse.de>
References: <jehd7527wq.fsf@sykes.suse.de>
	<1139783738.5247.54.camel@localhost.localdomain>
	<20060226173908.GA4871@suse.de>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 14:19:18 -0500
Message-Id: <1140981558.24141.112.camel@mindpipe>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-02-26 at 18:39 +0100, Olaf Hering wrote:
> /proc/device-tree/pci@f2000000/mac-io@17/gpio@50:
> linux,device     cfdc7808
> name             "gpio"
> linux,phandle    ff90fcd0
> reg              00000050 00000030
> built-in        
> device_type      "gpio"
> 

Argh, /proc abuse... "historical reasons" presumably?

Lee
