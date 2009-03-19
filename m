Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-05.bluehost.com (outbound-mail-05.bluehost.com
	[69.89.21.15]) by ozlabs.org (Postfix) with SMTP id 25BD9DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 11:06:09 +1100 (EST)
Received: from 72.25.32.200.dynamic.dejazzd.com ([72.25.32.200]
	helo=hp-dhlii.dlasys.lcl)
	by host200.hostmonster.com with esmtpa (Exim 4.69)
	(envelope-from <dhlii@dlasys.net>) id 1LkS93-0006BO-01
	for linuxppc-dev@ozlabs.org; Thu, 19 Mar 2009 17:59:29 -0600
Message-ID: <49C2DC5D.6000701@dlasys.net>
Date: Thu, 19 Mar 2009 19:59:25 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Xilinx cygwin linux cross recommendations ?
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: dhlii@dlasys.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    Does anyone have experience sugestions for building ppc/linux apps
or even ppc kernels under windows.

    I work (and live) under Linux. I am very happy to work under Linux. 
I only spend about 20 minutes a week in windows anymore.

    But I have coworkers, and clients that live under windows.
    Mostly I have them working under coLinux, but even that seems to be
too much for many of them.

    I have been able to mangle my build environment to  work under msys
and use the xilinx edk cross compiler to build standalone PPC apps,
    But the libraries do not seem to be present for linux applications.

    I build my own uclibc crosscompiler under linux from buildroot.
       Has anyone got experience doing that under windows ?

    Can I just copy the appropriate library binaries and use them with
the xilinx EDK cross compiler ? Presumably I need to match versions of GCC.

    Other suguestions ?

    Thanks.




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
