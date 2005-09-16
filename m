Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id D61B9682C2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Sep 2005 18:57:41 +1000 (EST)
Message-ID: <432A8902.8060203@anagramm.de>
Date: Fri, 16 Sep 2005 10:57:38 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Russell McGuire <rmcguire@uwbt.com>
References: <20050915191243.GA52539@mail19d.g19.rapidsite.net>
In-Reply-To: <20050915191243.GA52539@mail19d.g19.rapidsite.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Getting Perl on Embedded Linux PowerPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Russell!

Russell McGuire wrote:
> I was attempting to get some ATM Tools compiled into the embedded PowerPC,
> and found I needed Perl installed on the target before I continue.
> 
> So my question...
> 
> Has anyone had any luck getting any version of Perl 5 or higher installed
> onto the file system. I am still running this over the NFS dev environment,
> and plan to remove it before final production, so space is of no concern at
> the moment.  

I was compiling and running Perl on my mpc8540 system (natively)...
I haven't had any problems with that.

$ perl --version
This is perl, v5.8.6 built for ppc-linux

----- my (old) install log says:
perl:
        wget ftp://.../perl-5.8.6.tar.gz
	tar ...
        less INSTALL
        rm -f config.sh Policy.sh
        sh Configure
or
        sh Configure -de        (for default installation)
        make
        make test
and it should end up with something like:
All tests successful.
u=6.52  s=0.89  cu=415.95  cs=22.58  scripts=845  tests=87560
make[2]: Leaving directory `/home/clemens/build/perl-5.8.6'
make[1]: Leaving directory `/home/clemens/build/perl-5.8.6'
and finally:
	su -
        make install
-----

> Or perhaps a pre-compiled RPM that installs, that is built for PowerPC.

Sorry, no rpm's over here. Which PowerPC?

> I am using DENX Linux 2.4.25 at the moment, with pretty much the default
> root file system that is provided.

Should be no problem, I think. I started with that too, a long time ago.
Give it a try. You just need make sure that you don't run out of coffee! ;-)

Greets,

-- 
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
