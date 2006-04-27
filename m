Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 96FB567A6F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Apr 2006 04:07:46 +1000 (EST)
Date: Thu, 27 Apr 2006 11:07:43 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: PPC 405GPr support in linux 2.4.32
Message-ID: <20060427180743.GB11206@gate.ebshome.net>
References: <e2ov5s$1hn$1@sea.gmane.org> <20060426163540.H16236@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060426163540.H16236@cox.net>
Cc: Stephen Williams <steve@icarus.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Apr 26, 2006 at 04:35:40PM -0700, Matt Porter wrote:
> linuxppc-2.4 tree to linux-2.4. Oh, and Marcelo didn't want
> to take "new stuff" into linux-2.4 at that time either.
> 
> There's still rsync://source.mvista.com/linuxppc-2.4 available with
> the 405gpr/sycamore support.

There are bigger problems with 4xx support in 2.4 mainline than just 
missing some chips support.

Some parts which are already in 2.4 (e.g. ethernet driver) are of 
non-production quality. 

I can imagine Marcelo agreeing to commit 405GPr/405EP support as this 
change shouldn't break anything, but this will not make 2.4 support 
really useful for real world deployments. I think we are stuck with 
maintaining our own 2.4 trees with backports from 2.6. This is what I 
do myself of all our products (and yeah, diff between stock 2.4.32 and 
my internal version has already grown quite big to be acceptable for 
2.4 inclusion).

-- 
Eugene
