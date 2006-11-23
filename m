Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id EECBF67BC6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Nov 2006 18:35:14 +1100 (EST)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Perl
Date: Thu, 23 Nov 2006 08:26:36 +0100
References: <1163458589.5313.71.camel@mindpipe>
In-Reply-To: <1163458589.5313.71.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611230826.36163.matthias.fuchs@esd-electronics.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Lee,

there's a quick'n'dirty way to get a perl running on your CPU.
Take the Fedora Core 4 ppc binary rpm (perl-5.8.6-15.ppc.rpm) and install it 
from an ELDK 4 root filesystem:

bash-3.00# rpm -ihv --nodeps perl-5.8.6-15.ppc.rpm
warning: perl-5.8.6-15.ppc.rpm: Header V3 DSA signature: NOKEY, key ID 
4f2a6fd2
Preparing...                ########################################### [100%]
   1:perl                   ########################################### [100%]
bash-3.00# perl -v

This is perl, v5.8.6 built for ppc-linux-thread-multi

Copyright 1987-2004, Larry Wall

Perl may be copied only under the terms of either the Artistic License or the
GNU General Public License, which may be found in the Perl 5 source kit.

Complete documentation for Perl, including FAQ lists, should be found on
this system using `man perl' or `perldoc perl'.  If you have access to the
Internet, point your browser at http://www.perl.org/, the Perl Home Page.

bash-3.00# perl -e 'print "Hello World!\n";'
Hello World!
bash-3.00#

Note: This test has been done on a PPC405. But do not forget to use a kernel 
with math emulation for this to work. 

Matthias

On Monday 13 November 2006 23:56, Lee Revell wrote:
> I've been trying to cross compile Perl for a PPC440 board and it just
> isn't happening.  Perl is probably the least amenable application to
> cross compiling I've found.
> 
> I tried the instructions in the Cross/ directory of the Perl distro but
> they don't work - "sh Configure" fails on my target because it expects a
> full C development environment, which won't fit.
> 
> Is there any easy solution?  Can someone send me a binary?
> 
> Lee 
> 
