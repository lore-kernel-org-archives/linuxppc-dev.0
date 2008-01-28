Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 02F6BDDEF4
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 07:20:10 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org,
 michael@ellerman.id.au
Subject: Re: Patches added to for-2.6.25/master branches of powerpc.git
Date: Mon, 28 Jan 2008 21:19:40 +0100
References: <18330.53318.857148.409675@cargo.ozlabs.ibm.com>
	<1201394998.6659.3.camel@concordia>
In-Reply-To: <1201394998.6659.3.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200801282119.41403.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 27 January 2008, Michael Ellerman wrote:
> Can you grab these four assuming there's no objections in the meantime.
> 
> http://patchwork.ozlabs.org/linuxppc/patch?q=ellerman&id=16430
> http://patchwork.ozlabs.org/linuxppc/patch?q=ellerman&id=16433
> http://patchwork.ozlabs.org/linuxppc/patch?q=ellerman&id=16434
> http://patchwork.ozlabs.org/linuxppc/patch?q=ellerman&id=16437
> 

Yes, they all look good to me, you can add an
'Acked-by: Arnd Bergmann <arnd@arndb.de>' if you like.

What about your other series that adds the linear iommu mapping
for cell blades? Are you still waiting for more feedback and
testing on that, or can it also go in?

	Arnd <><
