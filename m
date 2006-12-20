Return-Path: <krafft@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11DCEDDF5B
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 01:49:31 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kBKEnQF3108050
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 14:49:26 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kBKEnQ7F1396892
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 14:49:26 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kBKEnPHY004411
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 14:49:26 GMT
Date: Wed, 20 Dec 2006 15:45:17 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Corey Minyard <minyard@acm.org>
Subject: Re: [patch 0/1] updated version
Message-ID: <20061220154517.6341fce6@localhost>
In-Reply-To: <45882913.2000609@acm.org>
References: <20061218163846.337fed65@localhost>
	<20061218164229.6a8b0df7@localhost>
	<A45F8443-A031-41AC-887C-669FABBE0F09@kernel.crashing.org>
	<20061219141245.679caa11@localhost>
	<33A5A5AA-3ECF-474E-90D4-584EEA7F37AD@kernel.crashing.org>
	<45882913.2000609@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bergmann <arnd@arndb.de>, Christian Krafft <krafft@linux.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, Arnd,
	openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm about to send an updated version,

I added=20
length check for the properties,
DEFAULT_REGSIZE,
simplified the comparison,

I did not fix the compiler warning.


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
