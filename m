Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3B7A467A46
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 05:50:58 +1100 (EST)
Date: Mon, 21 Mar 2005 10:50:56 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Guillaume Autran <gautran@mrv.com>
Message-ID: <20050321185056.GB11734@gate.ebshome.net>
References: <423F0FFB.10307@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <423F0FFB.10307@mrv.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC885 CryptoApi support.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Mar 21, 2005 at 01:18:35PM -0500, Guillaume Autran wrote:
> Is there any open source development done to integrate the MPC885 
> security coprocessor into the linux 2.6 kernel CryptoApi framework ?
> Did anyone wrote a driver for it yet ?

Current kernel CryptoAPI is lacking sane support for hw crypto engines 
(e.g. there is no async crypto). Until there is such generic support, 
it's highly difficult to efficiently integrate hw crypto into the 
kernel. I did such stuff for Hifn 7955 accelerator and didn't like the 
result :).

--
Eugene
