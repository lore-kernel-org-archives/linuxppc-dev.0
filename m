Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C58E6DE201
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 04:03:40 +1100 (EST)
In-Reply-To: <0F53B076-0A94-4A2D-8D9A-ED507B53ABE6@kernel.crashing.org>
References: <1207015715-31496-1-git-send-email-galak@kernel.crashing.org>
	<1207015715-31496-2-git-send-email-galak@kernel.crashing.org>
	<18418.2460.594352.712502@cargo.ozlabs.ibm.com>
	<5DBEA342-7674-414B-A666-B8FBEED34814@kernel.crashing.org>
	<18418.55835.338209.611273@cargo.ozlabs.ibm.com>
	<0F53B076-0A94-4A2D-8D9A-ED507B53ABE6@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9d4ced5e884e4d71a4665f207f22cd69@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 01/11] [POWERPC] bootwrapper: Allow specifying of image
	physical offset
Date: Wed, 2 Apr 2008 19:03:30 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Ideally we get set the phys address the PHDR, but I'm not sure how to 
> get the linker to do that.

I think you want to look at "AT" in the ld manual.


Segher
