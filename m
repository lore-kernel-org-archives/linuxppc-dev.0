Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40808041430q2d81f2a9i600e9ae17f658d01@mail.gmail.com>
Date: Mon, 4 Aug 2008 15:30:07 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: paul@mad-scientist.us
Subject: Re: Creating a wrapped zImage.initrd -- can't start the trampoline?
In-Reply-To: <1217878996.29051.560.camel@psmith-ubeta.netezza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1217644827.6390.12.camel@homebase.localnet>
	<20080804172558.GA18317@secretlab.ca>
	<1217878996.29051.560.camel@psmith-ubeta.netezza.com>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Aug 4, 2008 at 1:43 PM, Paul Smith <paul@mad-scientist.us> wrote:
> On Mon, 2008-08-04 at 11:25 -0600, Grant Likely wrote:
>> Take a look at Documentation/powerpc/bootwrapper.txt
>> You probably want the 'simpleImage.%' target.  It also binds in a copy
>> of the device tree blob.
>
> Hm.  I'm using 2.6.25.14 and I don't see any bootwrapper.txt file in
> Documentation/powerpc (or anywhere else).  I also can't see any target
> simpleImage in any makefile.  Is this something new in 2.6.26?  :-(
>
> Any help for folks still using 2.6.25?

It's new in .26, but it is relevant for .25 also.

Here's a link to it:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=Documentation/powerpc/bootwrapper.txt;h=d60fced5e1cc69169d9bbf1b49faacb41ef8db9c;hb=8f616cd5249e03c9e1b371623d85e76d4b86bbc1

> I think I need some basic instruction on how bootloaders etc. work, with
> a concentration on embedded PPC if possible.  Anyone have any pointers
> that would be worth investigating?

The document above should help.
Documentation/powerpc/booting-without-of.txt has some useful
information also.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
