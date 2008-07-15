Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id E635CDDE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 22:46:50 +1000 (EST)
Date: Tue, 15 Jul 2008 13:46:43 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: dinesh <dinesh.dua@coraltele.com>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA SoC: Add
	Texas	Instruments	TLV320AIC26 codec	driver
Message-ID: <20080715124642.GO25448@sirena.org.uk>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080712083939.15025.31192.stgit@trillian.secretlab.ca>
	<1216108672.9701.5.camel@dinesh.dua>
	<20080715103333.GM25448@sirena.org.uk>
	<1216125499.9701.16.camel@dinesh.dua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1216125499.9701.16.camel@dinesh.dua>
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

On Tue, Jul 15, 2008 at 06:08:19PM +0530, dinesh wrote:
> thanks for your response but there is no /dev/snd directory in my file
> structure is there any special method to create it please tell in
> detail.

The devices appear via the standard kernel interfaces so if you are
using udev or mdev they should be created automatically.  Otherwise
you'll need to create them statically using whatever method you usually
use (eg, a MAKEDEV script supplied by your distribution or manually by
reference to the device numbers exposed in /sys/class/sound/*/dev).

The ALSA devices use the standard Linux mechanisms to create their
devices so whatever you normally use to create devices should work for
ALSA too.
