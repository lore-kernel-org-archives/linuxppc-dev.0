Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.197])
	by ozlabs.org (Postfix) with ESMTP id 28904679F1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 May 2005 04:28:30 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 37so3266323wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 29 May 2005 11:28:29 -0700 (PDT)
Message-ID: <c3d0340b0505291128744538bc@mail.gmail.com>
Date: Sun, 29 May 2005 11:28:28 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: tuotuo wang <dvdstar@hotmail.com>
In-Reply-To: <BAY24-F3232D1E642991A24EBA041AD020@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <BAY24-F3232D1E642991A24EBA041AD020@phx.gbl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: load u-boot.bin failure with BDI2000
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> My target board is SBC8260,my debugger BDI2000,i have complied my u-boot
> file .But here is a mistake when i load it.Now i cann't enter the command
> line of u-boot.here is the display of BDI2000:
> - TARGET: processing user reset request
> - TARGET: Target PVR is 0x00810101
> - TARGET: reseting target passed
> - TARGET: processing target init list ....
> *** TARGET: processing target init list failed
> # PPC: Writing to workspace failed

There is somehting wrong with BDI2000 configuration file. Double check
what [INIT] section does for your target board.

-Shawn.
