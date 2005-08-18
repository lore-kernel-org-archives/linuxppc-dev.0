Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8278568061
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Aug 2005 04:09:53 +1000 (EST)
Date: Thu, 18 Aug 2005 15:01:29 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Studencki Pawel <pawel.studencki@siemens.com>
Message-ID: <20050818180129.GB7523@dmt.cnet>
References: <291992F9ECD9AB4F995C7E96B9A30DC008E081@nbgh103a.nbg6.siemens.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <291992F9ECD9AB4F995C7E96B9A30DC008E081@nbgh103a.nbg6.siemens.de>
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: segmentaion fault with array[4096]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!
On Thu, Aug 18, 2005 at 11:45:04AM +0200, Studencki Pawel wrote:
> hello,
> 
> because I want to do some tests with fusion/RTAI on my mpc852,
> I had to downgrade my system to kernel 2.6.10

Downgrade from what? 

> And I get a strange problem: if I start application with char array size
> 4096 (or even smaller 2600) I get "segmentation fault".
>
> Could someone gives me a hint? Is this kernel configuration problem?
> Where can I start looking for a reason?

Have you tried to debug the application with gdb to spot more precisely 
what is it doing that makes it receive a segfault? 

Most likely its doing an invalid memory access.
