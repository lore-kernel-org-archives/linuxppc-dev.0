Return-Path: <ajz@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2216D67A05
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 02:41:07 +1000 (EST)
Date: Tue, 9 May 2006 17:41:01 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
To: geneSmith <gd.smth@gmail.com>
Subject: Re: Viable PPC platform?
Message-Id: <20060509174101.389c67c0.ajz@cambridgebroadband.com>
In-Reply-To: <e3q9gu$vq8$1@sea.gmane.org>
References: <e3q9gu$vq8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 09 May 2006 10:38:19 -0400
geneSmith <gd.smth@gmail.com> wrote:

> I have a ppc405gpr system with 64M ram and 4Meg flash in a
> AM29LV320. Is this a viable platform for linux? Can a filesystem
> (JFFS2?) be put this flash type?
> 

I would create an initrd and put every file that doesn't need
to be changed persistently into it instead of JFFS2.

The reason for this is that if JFFS2 becomes too full (less than 5
free blocks) you may find that writes to it hang.

Alex

> -- 
> Lit up like Levy's
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
