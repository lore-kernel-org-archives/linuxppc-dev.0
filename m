Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E757F682D5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Sep 2005 08:41:33 +1000 (EST)
Date: Fri, 16 Sep 2005 15:41:31 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Tolunay Orkun <listmember@orkun.us>
Message-ID: <20050916224131.GA9941@gate.ebshome.net>
References: <432B3D99.5030209@orkun.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <432B3D99.5030209@orkun.us>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: squashfs on ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 16, 2005 at 04:48:09PM -0500, Tolunay Orkun wrote:
> Has anyone any positive or negative experience of using squashfs on 
> PowerPC as initrd?
> 
> Our environment is PowerPC 405GP running 2.4.31 kernel. U-Boot is our 
> bootloader. Any comparison with respect to CramFS?

I use squashfs and squashfs2. Both work just fine on PPC.

They provide significantly better compression ration than cramfs, 
although at the expense of some speed (mostly visible during initial 
startup of big user-space app).

-- 
Eugene
