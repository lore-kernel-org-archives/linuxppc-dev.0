Return-Path: <Stefan.Nickl@kontron.com>
Received: from kom-mail1.kontron-modular.com (unknown [62.159.155.196])
	by ozlabs.org (Postfix) with ESMTP id 7C6CA67A7A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Mar 2005 20:46:48 +1100 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Vijay Padiyar <vijay_padiyar@hotmail.com>
In-Reply-To: <BAY1-DAV1357D81F947F1A31523FE48B4F0@phx.gbl>
References: <BAY1-DAV1357D81F947F1A31523FE48B4F0@phx.gbl>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 10:46:45 +0100
Message-Id: <1111571205.13392.3.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: LinuxPPC Support <linuxppc-embedded@ozlabs.org>
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

On Wed, 2005-03-23 at 14:25 +0530, Vijay Padiyar wrote:
> Can you suggest some kind of a "synchronization" function which I can call
> from *user space* which will ensure that all values written to mmaped memory
> locations from user space are actually flushed to their physical locations?
> I think this might be a potential problem with my code.

Have a look at linux/include/asm-ppc/{io.h,system.h} and
http://www.xml.com/ldd/chapter/book/ch08.html

The eieio instruction doesn't need supervisor rights.

Greetings,

-- 
Stefan Nickl
Kontron Modular Computers
