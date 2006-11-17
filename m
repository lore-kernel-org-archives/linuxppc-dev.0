Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 05E4B67BDD
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Nov 2006 13:59:59 +1100 (EST)
Message-ID: <455D25DE.2040500@ovro.caltech.edu>
Date: Thu, 16 Nov 2006 19:00:46 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Leonid <Leonid@a-k-a.net>
Subject: Re: ELDK initial installation for FC 4.
References: <406A31B117F2734987636D6CCC93EE3C810B2D@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C810B2D@ehost011-3.exch011.intermedia.net>
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

Leonid wrote:
> Hi:
> 
> I've downloaded ppc-2006-01-11_amcc.iso file, burned it on CD, mounted
> CD, copied stuff into /opt/eldk, ran install - everything as explained
> on web. I have following stuff in /opt/eldk now:
> 
> [leonid@localhost eldk]$ ls -al
> total 564
> drwxr-xr-x  13 root root   4096 Nov 16 18:50 .
> drwxr-xr-x   5 root root   4096 Nov 16 17:33 ..
> drwxr-xr-x   2 root root   4096 Nov 16 18:51 bin
> drwxr-xr-x   2 1543 1543   4096 Jan 13  2006 common
> -rwxr-xr-x   1 1543 1543   1620 Jan  5  2005 ELDK_FIXOWNER
> -rwxrwxr-x   1 1543 1543   5468 Dec 17  2005 ELDK_MAKEDEV
> drwxr-xr-x   5 1543 1543   4096 Nov 16 18:50 etc
> drwxr-xr-x   2 1543 1543   4096 Jan 13  2006 icons
> -rwxr-xr-x   1 1543 1543 414416 Jan 13  2006 install
> drwxr-xr-x   3 1543 1543   4096 Jan 13  2006 ppc_4xx
> drwxr-xr-x   3 1543 1543   4096 Jan 13  2006 ppc_4xxFP
> -rw-rw-r--   1 1543 1543  73797 Jan  5  2006 README.html
> drwxr-xr-x   2 1543 1543   4096 Jan 13  2006 RPMS
> drwxr-xr-x   2 1543 1543   4096 Jan 13  2006 sys
> drwxr-xr-x   4 1543 1543   4096 Jan 13  2006 tools
> drwxr-xr-x  10 root root   4096 Nov 16 18:50 usr
> drwxr-xr-x   5 root root   4096 Nov 16 18:50 var
> -rw-r--r--   1 1543 1543     34 Jan 13  2006 version
> 
> Is it going to work for Fedora Core 4 my PC is running?

Why ask, just try it :)

I haven't had any trouble with Centos 4.x, which is the rip-off
of Red Hat Enterprise 4.x, which inherits from the FC4 series,
so I think you'll find it works fine.

Dave
