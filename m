Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BD95267A7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Feb 2005 21:18:50 +1100 (EST)
Date: Wed, 16 Feb 2005 02:18:47 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Demke Torsten-atd012 <torsten.demke@motorola.com>
Message-ID: <20050216101847.GB989@gate.ebshome.net>
References: <43395BE65409D911B9FF00110A9BFFDCDF4EF4@zwg57exm01.ea.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43395BE65409D911B9FF00110A9BFFDCDF4EF4@zwg57exm01.ea.mot.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Incomplete network configuration information when booting fro m
	NFS root on Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 16, 2005 at 11:09:10AM +0100, Demke Torsten-atd012 wrote:
> is this correct?
> nfsroot=192.68.0.47:/opt/eldk3.1/ppc_4xx
>             ^^
> ip=192.168.0.245:192.168.0.47:::::off
>                      ^^^
> 
> Why does your kernel uses the IP address 130.27.84.47
> (where comes this address from?), but not the IP address from u-boot?

[snip]

> > IP-Config: Incomplete network configuration information.
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

That's why. This is what original poster was asking, actually :)

--
Eugene  
