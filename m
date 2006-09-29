Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 8737467BC6
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 22:49:48 +1000 (EST)
Date: Fri, 29 Sep 2006 16:50:05 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: [PATCH 11/12] Add MPC8360EMDS default dts file
Message-ID: <20060929165005.31ed371e@vitb.ru.mvista.com>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D19DA6D@zch01exm20.fsl.freescale.net>
References: <20060928173816.168d4cc2@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19DA6D@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 29 Sep 2006 15:46:57 +0800
"Li Yang-r58472" <LeoLi@freescale.com> wrote:

> > -----Original Message-----
> > From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> > Sent: Thursday, September 28, 2006 9:38 PM
> > To: Li Yang-r58472
> > Cc: paulus@samba.org; galak@kernel.crashing.org;
> linuxppc-dev@ozlabs.org
> > Subject: Re: [PATCH 11/12] Add MPC8360EMDS default dts file
> > 
> > On Thu, 28 Sep 2006 16:19:30 +0800
> > Li Yang <leoli@freescale.com> wrote:
> > 
> > > +		muram@10000 {
> > > +			device_type = "muram";
> > > +			ranges = <0 00010000 0000c000>;
> > > +
> > > +			data-only@0{
> > > +				reg = <0 c000>;
> > > +			};
> > > +		};
> > > +
> > 
> > Why not to have reg property, showing the allocation ranges? data-only
> seems
> > redundant as a node...
> 
> The reason why I added this node is to put the address under "muram"
> bus.  If I put the reg in muram node, the address will be offset to QE
> base.  But what the driver needs is the offset to MURAM base.  IMHO,
> this approach is clearer logically.
> 
Correct. 

Well, IMO the information about dataonly is conceptually overkill for dts. 
But if devicetree masters are OK - that's even better to have it:)

-- 
Sincerely, 
Vitaly
