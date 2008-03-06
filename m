Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BECBDDDE07
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 03:12:10 +1100 (EST)
In-Reply-To: <7E836D6E-867B-4A35-9B3D-CD1D52E7F2DC@kernel.crashing.org>
References: <20080306135330.6d5462d2@vitb.ru.mvista.com>
	<7E836D6E-867B-4A35-9B3D-CD1D52E7F2DC@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aece767c51f5ab68c3012f1446cdd569@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [POWERPC] 8xx: fix swap
Date: Thu, 6 Mar 2008 17:12:03 +0100
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> do we need similar fixes to arch/ppc ?

Do we care?

arch/ppc needs many fixes, when you have implemented all of that, you
get a clone of arch/powerpc ;-)


Segher
