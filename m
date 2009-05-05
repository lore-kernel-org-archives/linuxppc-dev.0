Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 35449DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 16:36:14 +1000 (EST)
Date: Tue, 5 May 2009 08:35:53 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Need a patch tested on a windtunnel powermac
Message-ID: <20090505083553.7f8e6918@hyperion.delvare>
In-Reply-To: <20090504230216.3c8117cb@Jay>
References: <18936.58163.872136.772820@cargo.ozlabs.ibm.com>
	<20090504230216.3c8117cb@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 4 May 2009 23:02:16 +0200, Giuliano Pochini wrote:
> On Thu, 30 Apr 2009 09:30:59 +1000
> Paul Mackerras <paulus@samba.org> wrote:
> 
> > Does anyone here still have a "windtunnel" powermac (PowerMac3,6)
> > machine running Linux?  We need someone to test Jean Delvare's patch
> > to the therm_windtunnel driver.  The patch is at:
> > 
> > http://patchwork.ozlabs.org/patch/26095/
> > 
> > I don't have a windtunnel machine myself - I have a PowerMac3,5 but
> > not a PowerMac3,6.
> 
> I have a dual-G4 MDD (/proc/cpuinfo says PowerMac3,6).
> 
> On:
> 
> Linux Jay 2.6.30-rc4 #1 SMP Sun May 3 16:20:08 CEST 2009 ppc 7455, altivec supported PowerMac3,6 GNU/Linux
> 
> plus the patch above seems working fine as usual: temperature reports
> are written in the logs and fan speed changes correctly. therm_windtunnel
> is not compiled as module. I tested it for a few hours only.

Thanks for the report, Giuliano! I've added the information to the wiki.

-- 
Jean Delvare
