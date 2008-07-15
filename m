Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 03391DE039
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 20:33:41 +1000 (EST)
Date: Tue, 15 Jul 2008 11:33:34 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: dinesh <dinesh.dua@coraltele.com>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec	driver
Message-ID: <20080715103333.GM25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216108672.9701.5.camel@dinesh.dua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216108672.9701.5.camel@dinesh.dua>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 01:27:52PM +0530, dinesh wrote:

> I have one query about this soc driver.
>  I want to know when u will merge it with kernel then 
> where and by which name this device will be available
>  in /dev directory of your file system.

> As i am following the same structure for my driver so please help me. I
> am ot able to recognise the device in the file system.

It will appear via the standard ALSA interfaces (and OSS interfaces if
you enable OSS compatibility).  The standard location for ALSA device
files is under /dev/snd where you'll see several files per device.
