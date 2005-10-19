Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA8A2685ED
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Oct 2005 20:38:13 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: i2a <i2a@gmx.net>
In-Reply-To: <20051018191029.M22134@quicknet.nl>
References: <20051018191029.M22134@quicknet.nl>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 20:35:21 +1000
Message-Id: <1129718122.7620.207.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: openpic/mac-io
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-10-18 at 21:22 +0200, i2a wrote:
> Hi, 
> 
> I am searching for documentation about the OpenPIC interrupt-controller in mac
> systems. I found this site but most of the links are dead or give no hope on
> real technical documentation :).
> http://www.macbsd.com/openmac/refs.html
> 
> Could someone give any pointers or files?
> 
> I am also searching for any related documentation on the mac-io device (this
> could be a combo document).
> 
> I am trying to do a port as a masters project, and my biggest problem is:
> documentation :(.

Another interesting bit of docs is MacTech.pdf (google for it) which
documents an early version of the mac-io chip that was used on some CHRP
machines.

In general, there is no complete documentation. I would say that the
linux source code is probably the best you can get in this regard.

Feel free to ask me questions about details

Ben.
