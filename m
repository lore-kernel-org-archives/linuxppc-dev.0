Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id D9D6967A7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 05:44:07 +1100 (EST)
Message-ID: <42372CF0.6040901@mvista.com>
Date: Tue, 15 Mar 2005 11:44:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Greg Weeks <greg.weeks@timesys.com>
References: <4236D36D.3090809@timesys.com>
In-Reply-To: <4236D36D.3090809@timesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mtd maps
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greg Weeks wrote:

> Are mtd maps still in drivers/mtd/maps or has that all moved to the 
> platform code? I have an mtd map for the mpc8560ads but it's in mtd/maps.


The mtd code has changed so that platform code can get at the routines 
to set up the maps from there.  arch/ppc/platforms/katana.c has its mtd 
maps there and I recently posted a patch that moves it for the chestnut 
as well.

I think its a good idea to move them to the platform code since the mtd 
maps are platform specific anyway.  Plus its one less place to add/edit 
a file.  But that's just my $0.02...

Mark
