Return-Path: <aik@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F535B70DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Feb 2011 13:44:17 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p1L2i7sM023979
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Feb 2011 13:44:07 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1L2iExa1908920
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Feb 2011 13:44:16 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p1L2iEMI003472
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Feb 2011 13:44:14 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p1L2iEnZ003469
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Feb 2011 13:44:14 +1100
Received: from [10.61.2.175] (haven.au.ibm.com [9.190.164.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 509D973440
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Feb 2011 13:44:14 +1100 (EST)
Message-ID: <4D61D17D.2070301@au1.ibm.com>
Date: Mon, 21 Feb 2011 13:44:13 +1100
From: Alexey Kardashevskiy <aik@au1.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Per process DSCR + somefixes (try#3)
References: <4D5B62F2.3020709@au1.ibm.com>
In-Reply-To: <4D5B62F2.3020709@au1.ibm.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RHEL6 problem was that it crashed when doing
echo 3 > /sys/devices/system/cpu/dscr_default
because access methods for SYSDEV_ATTR and SYSDEV_CLASS_ATTR have 
different number of parameters in RHEL6. It was not correct for 2.6.36 
either but the parameters number is the same for both SYSDEV_ATTR and 
SYSDEV_CLASS_ATTR and 2.6.36 simply forgave me.


-- 
Alexey Kardashevskiy
IBM OzLabs, LTC Team

e-mail/sametime: aik@au1.ibm.com
notes: Alexey Kardashevskiy/Australia/IBM
