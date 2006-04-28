Return-Path: <info@schihei.de>
Received: from schihei.org (schihei.net [81.169.184.117])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 939F5679EA
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 16:11:36 +1000 (EST)
In-Reply-To: <1146177388.19236.1.camel@localhost.localdomain>
References: <4450A176.9000008@de.ibm.com>
	<20060427114355.GB32127@wohnheim.fh-wedel.de>
	<1146177388.19236.1.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6C4A3B96-4752-4FF9-8FBE-C383B00AE014@schihei.de>
From: Heiko J Schick <info@schihei.de>
Subject: Re: [openib-general] Re: [PATCH 04/16] ehca: userspace support
Date: Fri, 28 Apr 2006 08:11:08 +0200
To: Michael Ellerman <michael@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	=?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Michael,

On 28.04.2006, at 00:36, Michael Ellerman wrote:

> Try pr_debug() in include/linux/kernel.h

The problem I see with pr_debug() is that it could only activated via
a compile flag. To use the debug outputs you have to re-compile /  
compile
your own kernel.

Regards,
	Heiko
