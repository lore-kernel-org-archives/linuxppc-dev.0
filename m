Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id BA79EDDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 16:44:21 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so129994anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 21:44:19 -0800 (PST)
Message-ID: <fa686aa40801242144w7855e057s371fcf986f09730e@mail.gmail.com>
Date: Thu, 24 Jan 2008 22:44:18 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kim Phillips" <kim.phillips@freescale.com>
Subject: Re: [PATCH 8/9] powerpc: add the mpc837[789]_rdb dts files
In-Reply-To: <20080124204718.33a30ab5.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080124204718.33a30ab5.kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Joe D'Abbraccio <ljd015@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/24/08, Kim Phillips <kim.phillips@freescale.com> wrote:
> Add the dts files for the MPC838xE Reference Development Board (RDB).
>
> The board is a mini-ITX reference board with 256M DDR2, 8M flash,
> 32M NAND, USB, PCI, gigabit ethernet, SATA, and serial.
>
> the difference among the three files is the 8377 has two, the 8378
> none, and the 8379 has four sata controllers.

All who want to see macro support in dts please raise your hands....

Now we just need to find someone with the time to code it.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
