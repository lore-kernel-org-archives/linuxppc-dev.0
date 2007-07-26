Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18088.6185.491082.875891@cargo.ozlabs.ibm.com>
Date: Thu, 26 Jul 2007 13:42:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] Re: 2.6.22-git hangs during boot on PowerBook G3 in 0.0
	seconds
In-Reply-To: <20070724185946.722f34b5.kim.phillips@freescale.com>
References: <20070721192143.GA12144@nospam.com>
	<20070721212845.GA30977@nospam.com>
	<20070723172725.b1c14885.kim.phillips@freescale.com>
	<1185234923.5439.158.camel@localhost.localdomain>
	<20070724185946.722f34b5.kim.phillips@freescale.com>
Cc: Rutger Nijlunsing <rutger@nospam.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim Phillips writes:

> > In which circumstances are you trying to translate an address with no
> > size cell ?
> 
> for the enumerated PHYs. As the original commit comment states, I was
> getting these messages:
> 
> prom_parse: Bad cell count for /qe@e0100000/mdio@2120/ethernet-phy@00
> prom_parse: Bad cell count for /qe@e0100000/mdio@2120/ethernet-phy@01

Specifically, which of_address_to_resource or other call is producing
these error messages?

Paul.
