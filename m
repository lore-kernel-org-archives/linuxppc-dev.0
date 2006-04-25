Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AF5C367A5D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 06:04:07 +1000 (EST)
Date: Tue, 25 Apr 2006 13:04:04 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Andy Fleming <afleming@freescale.com>
Subject: Re: 85xx FDT updates?
Message-ID: <20060425200404.GF1132@gate.ebshome.net>
References: <4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<265F73F8-F641-4EDD-B88F-A2B2F7FA1308@kernel.crashing.org>
	<20060425182418.GA1132@gate.ebshome.net>
	<200604251329.35584.bcook@bpointsys.com>
	<20060425184857.GB1132@gate.ebshome.net>
	<F2D4EB11-5E74-4A8E-9F73-B5BFEB2B950C@freescale.com>
	<20060425192714.GD1132@gate.ebshome.net>
	<FB3CC275-6C15-414C-A1F2-F1A13E3E1279@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FB3CC275-6C15-414C-A1F2-F1A13E3E1279@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 25, 2006 at 02:58:34PM -0500, Andy Fleming wrote:
> Well, let's discuss this hypothetical shim layer.  It's fairly  
> straightforward to incorporate a device tree into the kernel, and  
> hook it up.  The only issue is the elements of the flat device tree  
> which are dynamic.  All of this information is passed in the bd_t or  
> the command line arguments, though, so it should be possible to hook  
> them up.
> 
> Would it be acceptable to require a new command-line argument (I'm  
> thinking specifically of the stdout device path, normally passed in  
> the "chosen" node of the oftree) to be passed in the bootargs?  Or is  
> u-boot absolutely unupdateable on these swiftly-aging systems?

Andy, I think we have to try to not making any changes to the way old 
U-Boot operates, including adding additional boot args. It doesn't 
matter _how_ information is passed between firmware and kernel (in 
bd_t or command line), the moment we add additional requirement 
which never existed before - we break this interface.

-- 
Eugene
