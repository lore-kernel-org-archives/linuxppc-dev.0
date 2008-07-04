Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 62BECDE08F
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 01:58:11 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1320869wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 08:58:09 -0700 (PDT)
Date: Fri, 4 Jul 2008 09:58:05 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: GPIO @ MPC5200
Message-ID: <20080704155805.GA17062@secretlab.ca>
References: <486DF3FA.3010806@matrix-vision.de>
	<20080704143619.GA15751@secretlab.ca>
	<486E3D76.5090207@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <486E3D76.5090207@matrix-vision.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 05:10:46PM +0200, Andre Schwarz wrote:
> I removed GPIO Lib and the problem is gone.
> I'm not yet using it anyway under linux - they're mainly for system
> configuration (setting up muxes etc.).
> 
> I'll dig into it when I have some time.

When you do, try adding "#define DEBUG" to the top of mpc52xx_gpio.c and
see what comes out of dmesg.

g.
