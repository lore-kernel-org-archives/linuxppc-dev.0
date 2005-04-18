Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7E8C467A6C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 02:03:13 +1000 (EST)
Date: Mon, 18 Apr 2005 09:03:06 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Pawel Studencki <pstudencki@yahoo.com>
Message-ID: <20050418160306.GF8014@gate.ebshome.net>
References: <20050418153442.83479.qmail@web51309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050418153442.83479.qmail@web51309.mail.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: using initramfs with ppc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 18, 2005 at 08:34:42AM -0700, Pawel Studencki wrote:
> Hello,
>  
> I use a custom board with 8xx and kernel 2.6.11 and
> try to mount root fs
> based on cramfs. I still have problems with mounting
> VFS:
> 
> VFS: Cannot open root device "mtdblock1" or
> unknown-block(31,1)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root
> fs on
> unknown-block(31,1)
> 
> I found, that perhaps the reason is initramfs.

Unlikely.

Please, check that you have mtdblock device enabled in config, also 
that you have configured your flash support, and mtdblock1 partition 
actually exists.

-- 
Eugene
