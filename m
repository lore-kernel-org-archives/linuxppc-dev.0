Return-Path: <frannk_m1@yahoo.com>
Received: from web32202.mail.mud.yahoo.com (web32202.mail.mud.yahoo.com
	[68.142.207.133]) by ozlabs.org (Postfix) with SMTP id 954BF679E0
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Aug 2006 06:43:29 +1000 (EST)
Message-ID: <20060804204327.16319.qmail@web32202.mail.mud.yahoo.com>
Date: Fri, 4 Aug 2006 13:43:27 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
Subject: Re: ELDK 3.1.1 support for x86_64 host architecture 
To: Wolfgang Denk <wd@denx.de>, Michael Carey <MCarey@nearfield.com>
In-Reply-To: <20060804201127.00D2D352640@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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



--- Wolfgang Denk <wd@denx.de> wrote:

> In message <44D22E43020000710000243E@webmail.nearfield.com>
> you wrote:
> > I found the subject "ELDK 3.1.1 support for x86_64 host
> architecture" in the archives (Apr 15 2005) which describes my
> problem, however there was never any posting of a resolution.
> 
> There was none, as  there  is  no  problem.  ELDK  3.1.1  (and
>  later
> versions)  runs  fine on x86_64 hosts, assuming you're using
> any sane
> Linux distribution. For example:
> 
> -> ppc_8xx-gcc -v
> Reading specs from
> /opt/eldk-3.1.1/usr/bin/../lib/gcc-lib/ppc-linux/3.3.3/specs
> Configured with: ../configure --prefix=/usr
> --mandir=/usr/share/man --infodir=/usr/share/info
> --enable-shared --enable-threads=posix --disable-checking
> --with-system-zlib --enable-__cxa_atexit --with-newlib
> --enable-languages=c,c++ --disable-libgcj
> --host=i386-redhat-linux --target=ppc-linux
> Thread model: posix
> gcc version 3.3.3 (DENX ELDK 3.1.1 3.3.3-9)
> ------------------------^^^^^^^^^^
There is something wrong with your Suse installation. I have
been using ELDK with Suse(9.2 and 10.1) since 2004 without any problems...

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
