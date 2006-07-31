Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7F430679FC
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Aug 2006 03:46:30 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6VHkOa7025279
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 13:46:25 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6VHkMvh075198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 13:46:23 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6VHkLvA014264
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Jul 2006 13:46:21 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] remove bogomips from /proc/cpuinfo
Date: Mon, 31 Jul 2006 19:46:17 +0200
References: <20060731125904.GA1997@suse.de>
In-Reply-To: <20060731125904.GA1997@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200607311946.18331.arnd.bergmann@de.ibm.com>
Cc: Paul Mackeras <paulus@samba.org>, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 31 July 2006 14:59, Olaf Hering wrote:
> Remove bogomips from /proc/cpuinfo.
> It is now really bogus since "timebase-frequency" is shown.

Well, but it's still part of the ABI, right?
How do you determine that there are no broken applications
still relying on it?

	Arnd <><
