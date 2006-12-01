Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 46B7767C25
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Dec 2006 02:50:40 +1100 (EST)
Message-ID: <45704F4D.6090507@anagramm.de>
Date: Fri, 01 Dec 2006 16:50:37 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Perl
References: <1163458589.5313.71.camel@mindpipe>
In-Reply-To: <1163458589.5313.71.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello, Lee!

Lee Revell schrieb:
> I've been trying to cross compile Perl for a PPC440 board and it just
> isn't happening.  Perl is probably the least amenable application to
> cross compiling I've found.
> 
> I tried the instructions in the Cross/ directory of the Perl distro but
> they don't work - "sh Configure" fails on my target because it expects a
> full C development environment, which won't fit.
> 
> Is there any easy solution?  Can someone send me a binary?

I don't know much about the ppc440 and it's core. But maybe you
can use mine?!
I am using perl successfully on a MPC8540 CPU which has an e500
core w/o an FPU. I don't need to cross compile and it comes with
only the necessary dependencies:

$ prt-get deptree perl
-- dependencies ([i] = installed, '-->' = seen before)
[i] perl
[i]   db
[i]   gdbm

all that on top of glibc-2.3.4
If you want to try those three tar.gz's please contact me off list
and I can send it to you.
It's also possible to recompile that stuff to a different ppc target...

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
