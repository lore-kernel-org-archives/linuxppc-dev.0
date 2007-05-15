Return-Path: <miroslaw.dach@psi.ch>
Received: from MAILSEND01.psi.ch (mailsend01.psi.ch [129.129.191.53])
	by ozlabs.org (Postfix) with ESMTP id 0A8DFDDED5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 22:57:42 +1000 (EST)
Date: Tue, 15 May 2007 14:45:33 +0200 (CEST)
From: Miroslaw Dach <miroslaw.dach@psi.ch>
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: zImage.elf loads but does not start
In-Reply-To: <4649A7AC.1050503@ru.mvista.com>
Message-ID: <Pine.LNX.4.44.0705151430120.7758-100000@slslc02.psi.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > [    9.357642] Freeing unused kernel memory: 96k init
> 
> Any NFS timeouts after reaching this point? Any network activity at all?
> (NFS timeout is quite long, so waiting few minutes would make sense)

I have monitored the network activity on the NFS server with program
ethereal. It seems to be that the root file system is mounted. There are
packet sent from a to my xilinx board. The /var/log/messages contains also
the entry that mount was done successfully. When init is executed the
ethereal show only individual packets which are sent (in fixed interval of
time - once per 20 seconds) from the NFS server to the client but client
seem to be dead. Even ping does not reach my xilinx board when kernel
executes the init.

I think that the best prove that the rootfile system is properly mounted
is the fact that my own test init function (which substitutes the real
init) which simply prints the string to the console does that what is
expected to do. The real init unfortunately does not print anything to the 
console.

Best Regards

Mirek
