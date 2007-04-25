Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] 64K page support for kexec
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Luke Browning <lukebr@linux.vnet.ibm.com>
In-Reply-To: <1177506360.24866.29.camel@luke-laptop>
References: <1177439513.24866.5.camel@luke-laptop>
	<1177454894.14873.142.camel@localhost.localdomain>
	<1177506360.24866.29.camel@luke-laptop>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 08:11:34 +1000
Message-Id: <1177539094.14873.191.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> OK.  I put it there mainly as a place holder.  How many page sizes do
> you expect to support in a 1TB segment? 

Not quite sure yet.. at least 16M and possibly 4K and 64K.

 .../...

> right.  The encoding is implementation dependent.  There is a minimum
> size requirement that comes into play, but that works the other way.
> penc of zero has a minimum page size requirement of 8K.
> 
> I will remove the test and use the array for the comparison.

Ok.

> yes. what you said is correct.  I was thinking that you might want to
> double the number of array elements so that you could apply a different
> hash algorithm based on the type of segments. 

The way our WIP patches for 1T segments do is we have separate psize and
ssize at every level where it matters. Anyway, let's leave that alone
for now. It will be easy enough to fixup.

Cheers,
Ben.
