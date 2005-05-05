Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp12.mail.mci.yahoo.co.jp (ybbsmtp12.mail.mci.yahoo.co.jp
	[210.80.241.186]) by ozlabs.org (Postfix) with SMTP id 36BC2679E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 May 2005 12:03:19 +1000 (EST)
Message-ID: <42797FDE.7080909@ybb.ne.jp>
Date: Thu, 05 May 2005 11:07:26 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Glenn Burkhardt <glenn@aoi-industries.com>
References: <20050419013712.AE32FB01E4@loki.aoi-industries.com>
	<42663E71.60005@ybb.ne.jp>
	<200504200802.45998.glenn@aoi-industries.com>
In-Reply-To: <200504200802.45998.glenn@aoi-industries.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: galak@freescale.com, linuxppc-embedded@ozlabs.org
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

Glenn Burkhardt wrote:

> watchdog exception interrupt isn't used, and it's only configurable for 
> PPC405 (although I think that the technique would work for the whole 4xx 
> family).
> 
> Or am I misreading the code?
> 
No, the kernel which I mentioned before is MontaVistaLinux.
IIRC, I look the WDT relevant codes in MontaVistaLinux2.X few years ago.
Of course, It was prepared for PowerPC40X...

> It would also be nice if your patch were applied to the 2.6 kernel tree.
> 
Sorry, It's not my jurisdiction.
Matt(Porter) or Kumar(Gala) may be responsible for this work.
#Finally, the patch should be approved by akpm and linus, of course...

Matt or Kumar, would you merge BOOKE_WDT patch to 2.6 kernel tree?
IIRC, This patch has been left under review state about two month.
Is there something to be needed for the patch?
