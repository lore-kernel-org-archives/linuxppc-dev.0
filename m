Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070808031643.GK10345@bakeyournoodle.com>
References: <20070807062231.GB8351@localhost.localdomain>
	<20070808031643.GK10345@bakeyournoodle.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7af683d3d78a51373d071b126c51b53a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Device tree aware EMAC driver
Date: Fri, 10 Aug 2007 22:39:31 +0200
To: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  * In drivers/net/ibm_newemac/Makefile, I think the preferred method is
>    to use ibm_newemac-y rather than ibm_newemac-objs.

I thought it was the other way around, so I checked with the
Kbuild maintainer, and indeed you are correct.


Segher
