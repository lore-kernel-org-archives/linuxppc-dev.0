Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89D2B679FB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Jun 2005 07:58:39 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1117655671.6517.99.camel@cashmere.sps.mot.com>
References: <1117614390.19020.24.camel@gaston>
	<1117655671.6517.99.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 07:58:21 +1000
Message-Id: <1117663102.19020.65.camel@gaston>
Mime-Version: 1.0
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: Booting the linux-ppc64 kernel & flattened device tree v0.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-06-01 at 14:54 -0500, Jon Loeliger wrote:
> On Wed, 2005-06-01 at 03:26, Benjamin Herrenschmidt wrote:
> > DO NOT REPLY TO ALL LISTS PLEASE ! (and CC me on replies).
> > 
> > Here's the fourth version of my document along with new kernel patches
> > for the new improved flattened format, and the first release of the
> > device-tree "compiler" tool. The patches will be posted as a reply to
> > this email. The compiler, dtc, can be downloaded, the URL is in the
> > document.
> > 
> > ---
> 
> > 
> > dtc source code can be found at <http://ozlabs.org/~dgibson/dtc/dtc.tar.gz>
> 
> Ben,
> 
> Here are diffs to:
> 
>     - Fix multi-line C-style comments.
> 
>     - Adjust the output of write_tree_source() such that it
>       separates properties and nodes a bit better.


Excellent, thanks. Please CC david next time.

Ben.
