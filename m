Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A4C467BC0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Jun 2006 23:36:22 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k58DaJiF008665
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 09:36:19 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k58DaFXR183404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 09:36:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k58DaFQV019488
	for <linuxppc-embedded@ozlabs.org>; Thu, 8 Jun 2006 09:36:15 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: a problem of kernel-module version mismatch.
Date: Thu, 8 Jun 2006 15:36:14 +0200
References: <BAY110-F1B771BD82DFE542552C0BB28B0@phx.gbl>
In-Reply-To: <BAY110-F1B771BD82DFE542552C0BB28B0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200606081536.15145.arnd.bergmann@de.ibm.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 08 June 2006 15:27, Ming Liu wrote:
> My embedded linux kernel version is 2.4.26. My compiler is 
> "powerpc-405-linux-gnu-gcc 3.4.1". I don't know how the version mismatch 
> happened. Shall I change another cross-compiler version? I will appreciate 
> a lot if someone could tell me how to solve it. Thanks a lot.

The easiest way is usually to put the driver in your source tree
and compile everything together. That also makes it easier to
distribute the complete source tree to your users.

> insmod: unresolved symbol XIo_In32
> insmod: unresolved symbol XIO_Out32

that looks like part of your module is missing. Try to find where thses
functions are defined in there and why that isn't compiled.

	Arnd <><
