Return-Path: <rubini@mail.gnudd.com>
Received: from mail.gnudd.com (mail2.gnudd.com [213.203.150.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2571EB7BB3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 09:39:34 +1100 (EST)
Date: Tue, 27 Oct 2009 23:32:21 +0100
From: Alessandro Rubini <rubini@gnudd.com>
To: Jonathan.Haws@sdl.usu.edu
Subject: Re: Accessing flash directly from User Space
Message-ID: <20091027223221.GA11293@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: rubini@gnudd.com
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu >
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
Cc: bgat@billgatliff.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Okay, I now have access to the flash memory, however when I write to
> it the writes do not take.


> 			(PROT_READ | PROT_WRITE), MAP_PRIVATE, fd,

MAP_SHARED. Bill told you.  With MAP_PRIVATE you write to a local
in-ram copy of the data, not to the original one.

/alessandro
