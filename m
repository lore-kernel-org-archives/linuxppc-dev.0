Return-Path: <pniyogi@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45C7967A75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 08:05:11 +1100 (EST)
Received: from e35.co.us.ibm.com (e35.esmtp.ibm.com [9.14.4.133])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id j1MIhWGS027021
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Feb 2005 13:43:33 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.10/8.12.9) with ESMTP id j1MIhQLg325746
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Feb 2005 13:43:26 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j1MIhQIb161968
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Feb 2005 11:43:26 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1MIhPWX001933
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Feb 2005 11:43:25 -0700
Received: from d03nm132.boulder.ibm.com (d03nm132.boulder.ibm.com
	[9.17.195.172])
	by d03av04.boulder.ibm.com (8.12.11/8.12.11) with ESMTP id
	j1MIhP0p001930
	for <linuxppc-embedded@ozlabs.org>; Tue, 22 Feb 2005 11:43:25 -0700
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OF9104AF94.598E2EE6-ON86256FB0.0066B44C-86256FB0.006707F3@us.ibm.com>
From: Prosun Niyogi <pniyogi@us.ibm.com>
Date: Tue, 22 Feb 2005 12:43:23 -0600
Content-Type: multipart/alternative;
	boundary="=_alternative 006707EF86256FB0_="
Subject: kgdb on 2.4.21 on Ebony
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 006707EF86256FB0_=
Content-Type: text/plain; charset="US-ASCII"

Has anyone used kgdb on a 2.4.21 kernel on 44x hardware? I am attempting 
to do this, but am running into problems with kgdb serial port setup. The 
gdb stub is not being transmitted correctly to the development machine. I 
would greatly appreciate it if someone who has done this before could 
point me to some documentation or explain their setup to me. Any pointers 
would be appreciated.

Thanks,

Prosun Niyogi
pniyogi@us.ibm.com
--=_alternative 006707EF86256FB0_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Has anyone used kgdb on a 2.4.21 kernel
on 44x hardware? I am attempting to do this, but am running into problems
with kgdb serial port setup. The gdb stub is not being transmitted correctly
to the development machine. I would greatly appreciate it if someone who
has done this before could point me to some documentation or explain their
setup to me. Any pointers would be appreciated.</font>
<br>
<br><font size=2 face="sans-serif">Thanks,</font>
<br>
<br><font size=2 face="sans-serif">Prosun Niyogi<br>
pniyogi@us.ibm.com</font>
--=_alternative 006707EF86256FB0_=--
