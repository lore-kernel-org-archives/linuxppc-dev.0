Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CA290DDEE2
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 06:49:15 +1100 (EST)
Message-ID: <476C1862.8080603@ru.mvista.com>
Date: Fri, 21 Dec 2007 22:47:46 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/4] PowerPC: update 440EP(x)/440GR(x) identical PVR issue
	workaround
References: <20071221160723.GA1430@ru.mvista.com>	<20071221162402.GA1673@ru.mvista.com>
	<20071221104347.54cd2ad5@zod.rchland.ibm.com>
In-Reply-To: <20071221104347.54cd2ad5@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Fri, 21 Dec 2007 19:24:02 +0300
> Valentine Barshak <vbarshak@ru.mvista.com> wrote:
> 
>> Commit 3ee133269861dc449ad5be761aa8570b1b05571f introduced
>> a CPU "model" property and thus broke PowerPC 440EP(x)/440GR(x)
>> identical PVR workaround. The patch updates it to use the new
>> model property for CPU identification.
> 
> Good catch.  I'll have to look more closely to see if anything else
> would be broken by changing the cpu node name from "PowerPC,xxxx@0" to
> "cpu@0".
> 
> josh

Looks like we need a u-boot update for 405Ex Kilauea board.
Mine (U-Boot 1.3.0-rc3-gccc2fe86-dirty (Oct 25 2007 - 12:18:41))
fails to boot with new cpu node changes:

    Uncompressing Kernel Image ... OK
    Booting using the fdt at 0x400000
le to update property /cpus/PowerPC,405EX@0:timebase-frequency, 
err=FDT_ERR_NOTFOUND
Unable to update property /cpus/PowerPC,405EX@0:clock-frequency, 
err=FDT_ERR_NOTFOUND

Thanks,
Valentine.
