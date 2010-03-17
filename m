Return-Path: <jgpobox@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 55898B7D0B
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Mar 2010 07:15:37 +1100 (EST)
Received: by gyf1 with SMTP id 1so653389gyf.15
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Mar 2010 13:15:35 -0700 (PDT)
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4BA13865.4080408@pobox.com>
Date: Wed, 17 Mar 2010 16:15:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>, Rupjyoti Sarmah <rsarmah@amcc.com>
Subject: Re: [PATCH] 460EX on-chip SATA driver<kernel 2.6.33> < resubmission
	: 01>
References: <1268646854-27387-1-git-send-email-rsarmah@appliedmicro.com>
	<AC311A8E81420D4EBC1F26E6479848FE065B7F30@SDCEXCHANGE01.ad.amcc.com>
	<201003171303.06258.sr@denx.de>
In-Reply-To: <201003171303.06258.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Rupjyoti Sarmah <rupjyoti.sarmah@appliedmicro.com>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Rupjyoti Sarmah <rupjyoti.sarmah@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/17/2010 08:03 AM, Stefan Roese wrote:
> Hi Rup,
>
> On Wednesday 17 March 2010 05:23:16 Rupjyoti Sarmah wrote:
>> This patch enables the on-chip DWC SATA controller of the AppliedMicro
>> processor 460EX.
>
> Apart from the other comments, did you take a look at the latest version of
> this driver in our linux-2.6-denx repository? We did some work on this driver
> for a new Canyonlands release last year. It's hard to check this for me now,
> with this line wrapped patch (the drivers diverged somewhat). So either check
> for yourself, or send a new, not line-wrapped, patch version so that I can
> better check myself.
>
> BTW: It would be nice if you would add me to Cc on DWC-SATA related patches,
> since I've been involved in the development at some time.

I will wait for Rupjyoti to check the linux-2.6-denx repo, and resend 
the patches without word wrapping.

	Jeff
