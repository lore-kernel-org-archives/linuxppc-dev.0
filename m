Return-Path: <scottwood@freescale.com>
Message-ID: <49060047.2010809@freescale.com>
Date: Mon, 27 Oct 2008 12:54:15 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com>
	<4900F90B.80703@firmworks.com>	<4901032F.3090805@genesi-usa.com>
	<49011C42.2020101@firmworks.com>	<49024646.3050300@genesi-usa.com>
	<49025DE0.6070403@firmworks.com>	<4904DD76.7070706@genesi-usa.com>	<20081026235303.GE22339@yookeroo.seuss>
	<4905E857.6040206@genesi-usa.com> <4905EDBE.8020105@freescale.com>
	<4905F4C4.4000309@genesi-usa.com>
	<4905F97B.60705@freescale.com> <4905FF2B.10007@genesi-usa.com>
In-Reply-To: <4905FF2B.10007@genesi-usa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Mitch Bradley <wmb@firmworks.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:
> Scott Wood wrote:
>> It's deprecated *in the context of flat device trees*.  Anything not 
>> using flat device trees is out-of-scope with respect to ePAPR.
> 
> Isn't the beauty of a device tree that every firmware no matter what
> type can present it in whatever form it chooses, but still be describing
> the same hardware in the same way?

When run-time services are not involved, yes.  device_type was used by 
1275 in the context of run-time services, which we don't have, so we 
didn't copy that property over (except for memory and cpu, to avoid 
gratuitous divergence).

> I'm curious, is it the remit of the ePAPR TSC to publish and act as
> a registration authority for device tree bindings for specific SoCs
> or is that devolved to the SoC maker itself (be they a member of
> Power.org or not) and, more prudent, two other questions; where are
> Freescale and IBM publishing these if it is their responsibility,
> are things like the mysterious i2c binding going to be published
> under this TSC?

There has been talk about setting up such a repository, but I'm not sure 
what the status of it is.

-Scott
