Return-Path: <benh@kernel.crashing.org>
Subject: Re: Merge dtc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5E3B6FCC-5930-4C76-AB4B-86B35551B9E0@kernel.crashing.org>
References: <20071016050217.GA9052@localhost.localdomain>
	<B17BEF48-34FC-44E0-AC23-1DB7522EB198@kernel.crashing.org>
	<18196.20112.728499.256646@cargo.ozlabs.ibm.com>
	<5E3B6FCC-5930-4C76-AB4B-86B35551B9E0@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 16:01:37 +1000
Message-Id: <1192514497.19073.29.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-16 at 00:50 -0500, Kumar Gala wrote:
> Just out of interest who's complaining?  We don't include mkimage
> for  
> u-boot related builds and I haven't seen any gripes related to that.

It's a pain in the neck since those are built even for things that don't
need them (such as 4xx where I use the treeboot images).

Ben.
