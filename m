From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: BootX (the MacOS X kind)
Date: Sat, 16 Dec 2000 23:09:16 +0100
Message-Id: <19341110154100.12112@192.168.1.10>
In-Reply-To: 
 <Pine.LNX.4.10.10012161929330.6742-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10012161929330.6742-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> 	After much cleaning and polishing, BootX has been moved to
>> the Darwin CVS Repository.  It should be available withing the hour.
>> Basically put, BootX is the booter for Mac OS X and Darwin OS.  It
>
>Is that one based on BenH's BootX? But that one needs MacOS to run, while
>Apple's tries to boot MacOS. Weird.
>Having BootX use my kernels on the ext2 filesystem would be nice though.

No, Apple's BootX is a completely different beast. It uses a BSD
implementation of ext2.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
