Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0F571400AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Apr 2014 10:08:54 +1000 (EST)
Message-ID: <1397002124.32034.322.camel@snotra.buserror.net>
Subject: Re: [1/2,v9] powerpc/mpc85xx:Add initial device tree support of T104x
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Tue, 8 Apr 2014 19:08:44 -0500
In-Reply-To: <53415417.3010802@freescale.com>
References: <1390650059-19437-1-git-send-email-prabhakar@freescale.com>
 <20140319223334.GA28875@home.buserror.net> <53415417.3010802@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Varun Sethi <Varun.Sethi@freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-04-06 at 18:48 +0530, Prabhakar Kushwaha wrote:
> On 3/20/2014 4:03 AM, Scott Wood wrote:
> > On Sat, Jan 25, 2014 at 05:10:59PM +0530, Prabhakar Kushwaha wrote:
> >> +	clockgen: global-utilities@e1000 {
> >> +		compatible = "fsl,t1040-clockgen", "fsl,qoriq-clockgen-2.0",
> >> +				   "fixed-clock";
> >> +		ranges = <0x0 0xe1000 0x1000>;
> >> +		clock-frequency = <100000000>;
> > Why is clock-frequency hardcoded here rather than supplied by U-Boot?
> > Especially since this is an SoC file, not a board file.
> 
> Your are correct.
> Means, clock-frequency should be added to clockgen in board device tree ??

Usually it gets patched in by U-Boot.

-Scott
