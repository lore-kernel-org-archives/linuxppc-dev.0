Message-ID: <404DA290.5080500@jonmasters.org>
Date: Tue, 09 Mar 2004 10:55:12 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Fillod Stephane <stephane.fillod@thomson.net>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: uncached user space mapping with mmap() ???
References: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFCA@renexch3.rennes.thmulti.com>
In-Reply-To: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFCA@renexch3.rennes.thmulti.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Fillod Stephane wrote:

> The bigger the mmap, the better, and the "lesser" entries in page table
> there will be.

That's not true though. I went along with the rest of your mail, but the
above just does not make sense to me.

Are you somehow assuming you can have variable page sizes or will
necessarily be using BATs to map in large regions? If this is the case
then do bear in mind the fixed 4K page size on most platforms and the
fact that many architectures like 4xx do not have any BATs anyway.

Cheers,

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
