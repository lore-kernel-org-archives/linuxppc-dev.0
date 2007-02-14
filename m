Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 85E39DDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:24:57 +1100 (EST)
Message-ID: <45D29D24.8040908@freescale.com>
Date: Tue, 13 Feb 2007 23:24:52 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Stuart Yoder <stuart.yoder@freescale.com>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <1171409687840-git-send-email-timur@freescale.com>
	<1171411075.20192.116.camel@localhost.localdomain>
	<45D29AE5.7090004@freescale.com>
	<20070214051924.GA12609@localhost.localdomain>
In-Reply-To: <20070214051924.GA12609@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Um.. you may be right in this case, but "the device tree compiler
> complains" is (sadly) not in general a good reason to decide
> something's bad.  The warning code in dtc is pretty bogus and
> complains about a number of things it shouldn't while failing to
> complain about some things it should.  I just haven't had time to make
> it much better.

I agree that the DTC has problems, but my understanding is that 
linux,boot-cpu is just plain wrong nowadays.  Besides, U-Boot overrides 
whatever is in the device tree, so it doesn't really matter what you say 
in the DTS.
