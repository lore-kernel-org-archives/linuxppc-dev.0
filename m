Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE004.bigfish.com (wa4ehsobe004.messaging.microsoft.com
	[216.32.181.14]) by ozlabs.org (Postfix) with ESMTP id C96CDDDE25
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 04:17:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Xilinx cygwin linux cross recommendations ?
Date: Mon, 23 Mar 2009 11:17:15 -0600
In-Reply-To: <49C2DC5D.6000701@dlasys.net>
References: <49C2DC5D.6000701@dlasys.net>
From: John Linn <John.Linn@xilinx.com>
To: <dhlii@dlasys.net>,
	<linuxppc-dev@ozlabs.org>
Message-ID: <20090323171717.5D3ECB2005D@mail163-wa4.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I agree that VmWare is a reasonable solution.

Some of our field guys, that don't do Linux everyday, use the ELDK in a
VmWare appliance and this seems reasonable.  We never had great luck
with cygwin stuff in this area.

-- John

> -----Original Message-----
> From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of David H. Lynch
Jr.
> Sent: Thursday, March 19, 2009 5:59 PM
> To: linuxppc-dev@ozlabs.org
> Subject: Xilinx cygwin linux cross recommendations ?
> =

> =

>     Does anyone have experience sugestions for building ppc/linux apps
> or even ppc kernels under windows.
> =

>     I work (and live) under Linux. I am very happy to work under
Linux.
> I only spend about 20 minutes a week in windows anymore.
> =

>     But I have coworkers, and clients that live under windows.
>     Mostly I have them working under coLinux, but even that seems to
be
> too much for many of them.
> =

>     I have been able to mangle my build environment to  work under
msys
> and use the xilinx edk cross compiler to build standalone PPC apps,
>     But the libraries do not seem to be present for linux
applications.
> =

>     I build my own uclibc crosscompiler under linux from buildroot.
>        Has anyone got experience doing that under windows ?
> =

>     Can I just copy the appropriate library binaries and use them with
> the xilinx EDK cross compiler ? Presumably I need to match versions of
GCC.
> =

>     Other suguestions ?
> =

>     Thanks.
> =

> =

> =

> =

> --
> Dave Lynch 					  	    DLA Systems
> Software Development:
Embedded Linux
> 717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
> fax: 1.253.369.9244 			           Cell: 1.717.587.7774
> Over 25 years' experience in platforms, languages, and technologies
too numerous to list.
> =

> "Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a
> lot of courage to move in the opposite direction."
> Albert Einstein
> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
