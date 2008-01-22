Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 0CB3FDDE28
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 03:47:45 +1100 (EST)
Subject: Re: [PATCH 1/2] Add flash node to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <06AA1424-0697-4AF8-B843-945211A5B54A@kernel.crashing.org>
References: <1201019917.5716.154.camel@rhino>
	<06AA1424-0697-4AF8-B843-945211A5B54A@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 22 Jan 2008 09:47:43 -0700
Message-Id: <1201020463.5716.161.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-01-22 at 10:44 -0600, Kumar Gala wrote:
> On Jan 22, 2008, at 10:38 AM, Wade Farnsworth wrote:
> 
> > Add flash and partition information to mpc8641_hpcn.dts
> >
> > Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>
> >
> > ---
> > arch/powerpc/boot/dts/mpc8641_hpcn.dts |   27 +++++++++++++++++++++++
> > 1 file changed, 27 insertions(+)
> >
> > diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/ 
> > boot/dts/mpc8641_hpcn.dts
> > index a719179..679e857 100644
> > --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> > +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> > @@ -457,4 +457,31 @@
> > 				  0 00100000>;
> > 		};
> > 	};
> 
> This really should be under a localbus node.
> 
> - k
> 

Ok. I'll fix it up and resend.

--Wade
