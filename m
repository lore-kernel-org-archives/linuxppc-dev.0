Return-Path: <scottwood@freescale.com>
Message-ID: <489B4F31.7050201@freescale.com>
Date: Thu, 07 Aug 2008 14:38:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [RFC/PATCH 2/3] of: add of_lookup_stdout() utility function
References: <489b4af2.199.1a42.425913876@bga.com>
	<489B4B89.1010507@freescale.com>
In-Reply-To: <489B4B89.1010507@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: devicetree-discuss@ozlabs.org, Yoder Stuart <stuart.yoder@freescale.com>,
	miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Milton Miller wrote:
> 
>> Why should what the hvc driver support have any effect on
>> what the binding should be?
> 
> Because my hypervisor console driver uses the hypervisor console/tty subsystem.
>  If the subsystem assumes one stdout/stdin device, then I must abide by that.

So fix the subsystem, don't use the subsystem, or live with the fact 
that you support a subset of what the device tree can express.  Don't 
cripple the device tree because of that.

-Scott
