Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7F3A367BC1
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 03:10:19 +1100 (EST)
Date: Thu, 2 Nov 2006 10:09:04 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: iommu_table & it_busno
Message-ID: <20061102100904.74b86ee9@localhost.localdomain>
In-Reply-To: <1162439128.8514.3.camel@localhost.localdomain>
References: <1162439128.8514.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 02 Nov 2006 14:45:28 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Hi Olof !
> 
> Do we ever use that it_busno field in there ? Can I remove it ?

It used to be there for debugging reasons, I think. I see no users of
it any more besides double free debug output. Go for it.


-Olof
