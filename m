Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15]) by ozlabs.org (Postfix) with ESMTP id 7E6CB67A39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 01:55:59 +1100 (EST)
Message-ID: <456AF9A5.70301@computing.dundee.ac.uk>
Date: Mon, 27 Nov 2006 14:43:49 +0000
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Using Linux on ML405: Some basic questions
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,

I am experimenting with Linux on an ML405 dev board in preparation for 
designing a board of our own.  I am not massively knowledgeable about 
Linux internals and am learning as I go along.  At the moment I'm 
working with a 2.4.26 kernel and the demonstration hardware 
configuration.  I have built the kernel and created a new root file 
systems using buildroot/busybox.  Most of the time I have a working 
system :)

I have a few questions, I was wondering if someone could help me out:

1) I don't really understand how the kernel image gets loaded from the 
.ace file.  I've seen articles which say that the SystemAce controller 
puts the kernel image directly into RAM, but on inspection of the 
datasheet I can't see any capability other that JTAG programming and 
acting as a slave to a processor.  Can anyone explain the way this works?

2) I'm trying to simplify the kernel as much as possible, is there a way 
to do without devfs?  If I don't have devfs do I need an initrd?  If so, 
what do I need to put on the initrd, can it just be a minimal /dev 
directory?

3) I will eventually be wanting tri-mode ethernet support, ideally under 
a 2.6 kernel.  I've been trying to follow the discussions on this 
mailing list with respect to the support for the tri-mode MAC and 
scatter gather/DMA support.  Can anyone summarise what sort of stage 
this is at? Is auto-negotiation supported? Once I get past the hurdles I 
have at the moment my next step is to attempt incorporating the tri-mode 
IP and getting it working under Linux.  If there's anything I can do to 
help the effort at that point I'd be glad to put in some time.

Many thanks in advance,
-- Peter
