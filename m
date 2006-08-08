Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 46A2967B61
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 02:48:17 +1000 (EST)
Message-ID: <44D8C02D.1070205@ovro.caltech.edu>
Date: Tue, 08 Aug 2006 09:47:41 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: chun fung siu <vows_siu@yahoo.com.hk>
Subject: Re: Trouble on building crossover compiler for Synology 8041 PPC
	based NAS
References: <20060808161050.33138.qmail@web50801.mail.yahoo.com>
In-Reply-To: <20060808161050.33138.qmail@web50801.mail.yahoo.com>
Content-Type: text/plain; charset=Big5
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

chun fung siu wrote:
> Hi,
>  
> I recently bought a Synology Network Attached Server DS-106e, run using 
> a "Linux 2. 4.22-uc-0" Kernel, under 8041 PPC, no "gcc" installed. I 
> want to build a crosslink gcc compiler for it in another "debian 2.6 
> kernel" linux. I find many options in the crosslink build script on ppc, 
> but can't find any option for 8041 PPC. So what option should I choose? 
> And further can I put the artifacts just compiled in my Network Attached 
> Server? So that I can compile anything directly in my NAS.

The processor is probably an *MPC8241*.

The DS101g is also an MPC8241. So this should provide you with
some useful info:

http://www.nslu2-linux.org/wiki/DS101/HomePage
http://www.nslu2-linux.org/wiki/DS101/DS101GHardware

Dave
