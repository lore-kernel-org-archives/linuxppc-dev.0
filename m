Message-ID: <B25E2E5A003CD311B61E00902778AF2A8AECF6@SERVER1>
From: Ellie Abdollahi <ellie@SkyStream.com>
To: "'Dan Malek'" <dan@netx4.com>,
        Graham Stoney
	 <greyham@research.canon.com.au>
Cc: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Journeyman configure/build options for gcc & glibc?
Date: Tue, 15 Aug 2000 13:22:33 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is Perl module supported in the CDK?
What is the cost of using Perl with CGI? how much memory space does the Perl
Module use? what is going to be the impact on the size of the kernel.


-----Original Message-----
From: Dan Malek [mailto:dan@netx4.com]
Sent: Tuesday, August 15, 2000 8:09 AM
To: Graham Stoney
Cc: LinuxPPC Embedded Mailing List
Subject: Re: Journeyman configure/build options for gcc & glibc?



Graham Stoney wrote:
>
> I thought I had the whole soft-float thing on 8xx worked out long ago,
until I
> upgraded our root filesystem to the one from MontaVista's Journeyman kit,

The lastest CDK 1.2 has been released, so you may want to use that.

The MontaVista CDK is created to work as a complete kit.  I don't know
all of the details, but the binutils, compilers, run-time start up,
libraries, header files, and applications are all built to work together.
There is an 8xx set of everything that "just works" together.  Mixing
among various tools/libraries has never worked at any time in history and
that continues to be the case.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
