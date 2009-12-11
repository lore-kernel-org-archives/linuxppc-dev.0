Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
	by ozlabs.org (Postfix) with ESMTP id BFA09B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Dec 2009 02:49:31 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: AltiVec in the kernel
Date: Fri, 11 Dec 2009 16:49:25 +0100
References: <20091211114543.GF24650@honey.hogyros.de>
In-Reply-To: <20091211114543.GF24650@honey.hogyros.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912111649.25617.arnd@arndb.de>
Cc: Simon Richter <Simon.Richter@hogyros.de>,
	Sebastian Siewior <bigeasy@breakpoint.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 11 December 2009, Simon Richter wrote:
> Hi,
> 
> since there has been a thread on allowing the use of a coprocessor in
> the kernel already: I am wondering if it'd make sense to use AltiVec for
> AES in dm-crypt, and how difficult it would be to implement that.
> 
> I'm using a PegasosII which has a G4 running at 1 GHz; I get around 3
> MB/s throughput when accessing harddisks. I think that could be
> improved.
> 
> If I understand correctly, the actual encryption work runs in a kernel
> thread, which is scheduled normally, so it ought to be possible to
> enable AltiVec for that thread; am I missing something here?

Sebastian Siewior has implemented this some time ago:

http://old.nabble.com/-RFC-0-3--Experiments-with-AES-AltiVec,-part-2-tc10034255.html

You can try the old patches on your machine to see if they are any good
there.

	Arnd <><
