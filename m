Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp07.mail.mci.yahoo.co.jp (ybbsmtp07.mail.mci.yahoo.co.jp
	[210.80.241.156]) by ozlabs.org (Postfix) with SMTP id B993367A33
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Apr 2005 21:39:05 +1000 (EST)
Message-ID: <42663E71.60005@ybb.ne.jp>
Date: Wed, 20 Apr 2005 20:35:13 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Glenn Burkhardt <glenn@aoi-industries.com>
References: <20050419013712.AE32FB01E4@loki.aoi-industries.com>
In-Reply-To: <20050419013712.AE32FB01E4@loki.aoi-industries.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC 44x Watchdog timer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

IIRC, MontaVistaLinux has this feature.
As far as I know, I found it in Monta Vista Linux 3 years ago at least.
I've not checked resent kernel of Monta Vista Linux, so I am sorry if
it is wrong now.

Glenn Burkhardt wrote:
> Is there a patch for the built in watchdog timer in the 440GP available
> anywhere for the 2.4 kernel (viz., ELDK kernels)?
> 
By the way, BOOKE_WDT patch has not been commited to up-stream kernel.
Matt(or Kumar?), please apply the patch.

Regards,
