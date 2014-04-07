Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5C2331400BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Apr 2014 04:22:25 +1000 (EST)
Message-ID: <1396894931.32034.168.camel@snotra.buserror.net>
Subject: Re: [1/2,v9] powerpc/mpc85xx:Add initial device tree support of T104x
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Mon, 7 Apr 2014 13:22:11 -0500
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
> >> +	display@180000 {
> >> +		compatible = "fsl,t1040-diu", "fsl,diu";
> >> +		reg = <0x180000 1000>;
> >> +		interrupts = <74 2 0 0>;
> >> +	};
> >> +
> >> +/include/ "qoriq-sata2-0.dtsi"
> >> +sata@220000 {
> >> +			fsl,iommu-parent = <&pamu0>;
> >> +			fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
> >> +};
> >> +/include/ "qoriq-sata2-1.dtsi"
> >> +sata@221000 {
> >> +			fsl,iommu-parent = <&pamu0>;
> >> +			fsl,liodn-reg = <&guts 0x554>; /* SATA2LIODNR */
> >> +};
> >> +/include/ "qoriq-sec5.0-0.dtsi"
> >> +};
> > Whitespace
> >
> >
> i did not find this whitespace :(

Add a tab to the sata nodes' name and braces, and remove a tab from the
sata nodes' content.

-Scott
