Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1719CDE58D
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 02:41:40 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m4KGfagH011770
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 09:41:36 -0700 (MST)
Message-ID: <4832FF80.5080408@freescale.com>
Date: Tue, 20 May 2008 11:42:40 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: .dtb file for mpc8641_hpcn failing on recent kernel/u-boot.
References: <loom.20080519T223903-170@post.gmane.org>	<20080519180337.234b11b4.kim.phillips@freescale.com>
	<4832FDE8.50902@freescale.com>
In-Reply-To: <4832FDE8.50902@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Kim Phillips wrote:
>> On Mon, 19 May 2008 22:57:29 +0000 (UTC)
>> Gary Hannon <ghannon@cspi.com> wrote:
>>
>>
>>> Am I missing a flag on the dtc?
>> try adding -R 8 -S 0x3000 to the dtc command line.
> 
> Maybe we should be making this the default for dtc?  After all, it's needed for
> any modern U-boot.

How about fixing u-boot's deficiencies in u-boot?  It knows better than 
dtc how much extra space it's going to need.

-Scott
