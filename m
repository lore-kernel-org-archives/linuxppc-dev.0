Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id AE417DDD0B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Nov 2008 01:50:50 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so766444ywh.39
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Nov 2008 06:50:48 -0800 (PST)
Message-ID: <fa686aa40811240650l4691851coee57951f9fe046c7@mail.gmail.com>
Date: Mon, 24 Nov 2008 07:50:48 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Naveen Kumar" <naveenkumar_v@infotechsw.com>
Subject: Re: Regarding MPC5200
In-Reply-To: <200811240740.mAO7eS4X013348@mail.infotechsw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <113760FDF39C3E40AAB8DE6E6C64D0A781B747@zch01exm26.fsl.freescale.net>
	<200811240740.mAO7eS4X013348@mail.infotechsw.com>
Cc: Joaquin Luna <Joaquin.Luna@jdsu.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 24, 2008 at 12:37 AM, Naveen Kumar
<naveenkumar_v@infotechsw.com> wrote:
> HI,
> I am using the MPc5200 processor(TQM5200) board with stk5200 base board for
> porting embedded Linux kernel 2.4.25 denx distribution with U-boot loader.
> Am trying to compile the drivers for my atheroes chipset AR5006x series with
> madwifi able to load the driver and see the wireless interface by ifconfig
> command and do self ping but unavle to connect to the Access point or the
> other wlan module.

Is there any particular reason that you're using a 2.4 kernel?
Current 2.6 kernels have much better MPC5200 support, including
support for the TQM5200.  As for your question you'd probably be
better off asking on either the wireless or Madwifi mailing lists
where people are more familiar with wireless issues.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
