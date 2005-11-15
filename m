Return-Path: <cfriesen@nortel.com>
Message-ID: <437A6C2E.1020807@nortel.com>
Date: Tue, 15 Nov 2005 17:15:58 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
References: <437A5049.9090308@nortel.com> <200511152338.53238.arnd@arndb.de>
In-Reply-To: <200511152338.53238.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc64-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: modify the cache-inhibit and guard bits from userspace?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:

> I have seen an earlier patch that modifies madvise to do this, which seems
> a little saner than mprotect, although they can probably both be implemented
> in a similar way.

Ah, that would make sense.  It does fit the intent of the function a bit 
better.

> Alternatively, you could write a new file system similar to hugetlbfs and set 
> the cache-inhibit bit in its mmap function.

Also a possibility.  I think the madvise method is a bit cleaner for the 
apps.

Chris
