Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5BA8767A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 04:10:49 +1100 (EST)
Date: Wed, 23 Mar 2005 09:10:46 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Nickl <Stefan.Nickl@kontron.com>
Message-ID: <20050323171046.GA28922@gate.ebshome.net>
References: <BAY1-DAV1357D81F947F1A31523FE48B4F0@phx.gbl>
	<1111571205.13392.3.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1111571205.13392.3.camel@lucy.pep-kaufbeuren.de>
Cc: Vijay Padiyar <vijay_padiyar@hotmail.com>,
	LinuxPPC Support <linuxppc-embedded@ozlabs.org>
Subject: Re: question about writing to memory directly from user space in
	Linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Mar 23, 2005 at 10:46:45AM +0100, Stefan Nickl wrote:
> On Wed, 2005-03-23 at 14:25 +0530, Vijay Padiyar wrote:
> > Can you suggest some kind of a "synchronization" function which I can call
> > from *user space* which will ensure that all values written to mmaped memory
> > locations from user space are actually flushed to their physical locations?
> > I think this might be a potential problem with my code.
> 
> Have a look at linux/include/asm-ppc/{io.h,system.h} and
> http://www.xml.com/ldd/chapter/book/ch08.html
> 
> The eieio instruction doesn't need supervisor rights.

eieio is a nop on 603e core.

--
Eugene
