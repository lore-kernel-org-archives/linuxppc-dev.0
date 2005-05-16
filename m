Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 62D1B679EB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 02:25:26 +1000 (EST)
In-Reply-To: <20050516153939.6CF17C1512@atlas.denx.de>
References: <20050516153939.6CF17C1512@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <7bba70c93cea3585269a98b62de4777f@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 16 May 2005 11:25:19 -0500
To: "Wolfgang Denk" <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Missing m8260_cpm_dpfree() 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On May 16, 2005, at 10:39 AM, Wolfgang Denk wrote:

> In message <20050516161503.0081b1b0.ajz@cambridgebroadband.com> you=20
> wrote:
>  >
> > I have a question about the MPC8260 dual port RAM allocation=20
> routines.
>  >
> > In arch/ppc/8260_io/commproc.c this is a=A0 m8260_cpm_dpalloc()=20
> routine,
>  > but the m8260_cpm_dpfree() routine is missing.=A0 Does anybody know=20=

> where
>  > I can find this?
>
> It was never implemented.
>
> We added this in the context of the 8xx tree, and submitted=A0 it=A0 =
here
>  at least twice. The patches were never accepted for the publich sourc
>  trees,=A0 so=A0 we=A0 stopped=A0 wasting=A0 our=A0 time on this. I =
think Pantelis
>  Antoniou (?) submitted similar code later, but I don't remember=A0 =
what
>  happened to it.

The 2.6 kernel has a better set of functions around managing cpm memory=20=

based on changes from Pantelis.

- kumar
