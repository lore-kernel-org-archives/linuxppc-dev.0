Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E62F67CC7
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 09:37:19 +1000 (EST)
Subject: Re: [PATCH] powerpc: make U4 PCIe work
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20061005225258.GP24705@localdomain>
References: <1160024098.22232.13.camel@localhost.localdomain>
	<0B8F6C29-A29A-4084-B9AB-9BCC9A1A4038@kernel.crashing.org>
	<1160087213.22232.76.camel@localhost.localdomain>
	<20061005225258.GP24705@localdomain>
Content-Type: text/plain
Date: Fri, 06 Oct 2006 09:37:09 +1000
Message-Id: <1160091429.22232.96.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-05 at 17:52 -0500, Nathan Lynch wrote:
> Benjamin Herrenschmidt wrote:
> > 
> > At this point, the patch should go in as it is.
> 
> At the very least, please fix those macros; I already pointed out the
> bug to you.

Ah yes, missed that bit of your mail. Interesting.

Ben.
