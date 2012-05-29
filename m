Return-Path: <michael@ellerman.id.au>
Message-ID: <1338281663.15519.2.camel@concordia>
Subject: RE: pread() and pwrite() system calls
From: Michael Ellerman <michael@ellerman.id.au>
To: David Laight <David.Laight@ACULAB.COM>
Date: Tue, 29 May 2012 18:54:23 +1000
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6F29@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6F29@saturn3.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-05-29 at 09:28 +0100, David Laight wrote:
> > > A special pread/pwrite asm stub that just copies
> > > r7 to r0 could be used.
> > > 
> > > Would it be enough to do:
> > > syscall_pread_pwrite:
> > > 	mov 0,7
> > > 	sc
> > > 	blr
> > > and handle the -ve -> errno in C?
> > 
> > Huh? Won't fly, r0 is used for the system call number!
> 
> I was copying that from r7!

Using the non-existant 'mov' instruction!

or 0,7,7

is much clearer :)

cheers
