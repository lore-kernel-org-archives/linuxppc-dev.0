Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 3B269DDE2A
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 04:30:01 +1000 (EST)
Date: Fri, 17 Aug 2007 20:30:13 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] advertise correct IDE mode on Pegasos2
Message-ID: <20070817183013.GA769@aepfle.de>
References: <20070404111635.GA1855@aepfle.de>
	<20070817131048.GA31192@aepfle.de>
	<20070817143311.GA32390@aepfle.de>
	<46C5E6B9.6080408@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <46C5E6B9.6080408@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 17, Matt Sealey wrote:

> Setting them to ~0x5 will set them to 0 (legacy mode) and they will always 
> read
> back as 0 (legacy mode.. sigh) even if in native mode.

The pci_dev->class needs updating as well, see second version of the
patch.
