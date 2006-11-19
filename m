Return-Path: <nd@bplan-gmbh.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id E96F4679E9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 20 Nov 2006 06:15:03 +1100 (EST)
Date: Sun, 19 Nov 2006 20:14:09 +0100 (MET)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH/RFC] ata: Add support for the MPC52xx ATA controller using
	libata
Message-Id: <20061119201411.b5dd5dd5.nd@bplan-gmbh.de>
In-Reply-To: <455E4406.8050405@246tNt.com>
References: <11637151391017-git-send-email-tnt@246tNt.com>	<200611172049.49260.jarno.manninen@tut.fi>	<455E0907.8000009@246tNt.com>	<455E3A7E.3030807@garzik.org>	<455E4406.8050405@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linux IDE <linux-ide@vger.kernel.org>, Sven Luther <sl@bplan-gmbh.de>,
	Jeff Garzik <jeff@garzik.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 18 Nov 2006 00:21:42 +0100
Sylvain Munaut <tnt@246tNt.com> wrote:


> Aside from that, does the driver looks ok ? It has been tested ok on another
> 5200b platform as well. I'd like to include it in a patch set I'll probably
> send next weekend. I'll try to add the timing computation to the generic
> call and make use of those.
> 
> 

I succefully tested the driver on Efika 5k2: I booted my root fs and did 2 min badblocks. No problems.

Regards,
