Return-Path: <pochini@shiny.it>
Received: from smtp-out25.alice.it (smtp-out25.alice.it [85.33.2.25])
	by ozlabs.org (Postfix) with ESMTP id A4608DDDA5
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 07:09:12 +1000 (EST)
Date: Mon, 4 May 2009 23:02:16 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Need a patch tested on a windtunnel powermac
Message-ID: <20090504230216.3c8117cb@Jay>
In-Reply-To: <18936.58163.872136.772820@cargo.ozlabs.ibm.com>
References: <18936.58163.872136.772820@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 30 Apr 2009 09:30:59 +1000
Paul Mackerras <paulus@samba.org> wrote:

> Does anyone here still have a "windtunnel" powermac (PowerMac3,6)
> machine running Linux?  We need someone to test Jean Delvare's patch
> to the therm_windtunnel driver.  The patch is at:
> 
> http://patchwork.ozlabs.org/patch/26095/
> 
> I don't have a windtunnel machine myself - I have a PowerMac3,5 but
> not a PowerMac3,6.

I have a dual-G4 MDD (/proc/cpuinfo says PowerMac3,6).

On:

Linux Jay 2.6.30-rc4 #1 SMP Sun May 3 16:20:08 CEST 2009 ppc 7455, altivec supported PowerMac3,6 GNU/Linux

plus the patch above seems working fine as usual: temperature reports
are written in the logs and fan speed changes correctly. therm_windtunnel
is not compiled as module. I tested it for a few hours only.



-- 
Giuliano.
