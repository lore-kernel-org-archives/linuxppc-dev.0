Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F2C2B71A0
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2011 09:58:08 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] drivers/misc: introduce Freescale Data Collection
	Manager driver
Date: Mon, 1 Aug 2011 23:58:00 +0000
Message-ID: <4E373D88.80006@freescale.com>
References: <1312235334-15036-1-git-send-email-timur@freescale.com>
	<20110801234645.GA15792@sirena.org.uk>
In-Reply-To: <20110801234645.GA15792@sirena.org.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Brown wrote:
> On Mon, Aug 01, 2011 at 04:48:54PM -0500, Timur Tabi wrote:
>> The Data Collection Manager (DCM) is a feature of the FPGA on some Frees=
cale
>> PowerPC reference boards that can read temperature, current, and voltage
>> settings from the sensors on those boards.  This driver exposes the DCM =
via a
>> sysfs interface (/sys/devices/platform/fsl-ocm.0).
>
> This sounds like it should be a hwmon driver.

I didn't see any way to interface the hardware to the hwmon layer in a=20
manner that provides the information that our customers went using this=20
hardware.

>> The DCM collects and tallies data over a period of time in the backgroun=
d,
>> without utilizing any resources on the host (CPU, memory, etc).  The dat=
a is
>> summarized and made available when data collection stops.  This allows p=
ower
>> consumption to be measured while the host is performing some tasks (usua=
lly
>> a benchmark).
>
> Though this is a bit odd for the subsystem I don't think it's too far
> out of what other hwmon chips can do, some of them do have longer term
> stats than just instantaneous readings.

Can you show an example or some documentation?  I couldn't find anything=20
remotely like that.  I don't even see anything that lets me start/stop=20
monitoring of sensors.

--=20
Timur Tabi
Linux kernel developer at Freescale=
