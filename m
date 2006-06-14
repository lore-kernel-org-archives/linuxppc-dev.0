Return-Path: <mkravetz@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7068E67B73
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 09:52:20 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5ENqH6H024946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 19:52:17 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5ENqHwS263874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 19:52:17 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5ENqGm2010150
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 19:52:17 -0400
Date: Wed, 14 Jun 2006 16:52:17 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060614235217.GA3876@monkey.ibm.com>
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614035258.GC6759@monkey.ibm.com>
	<20060614144230.GE26750@localdomain>
	<17552.36563.460775.131555@cargo.ozlabs.ibm.com>
	<20060614224040.GH26750@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060614224040.GH26750@localdomain>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 14, 2006 at 05:40:40PM -0500, Nathan Lynch wrote:
> Makes sense... then perhaps the stats shouldn't be exported in per-cpu
> files in sysfs, and the kernel should calculate and report the totals
> to userspace in some other form.

I'm really wondering what would be the best way to make these stats
available to userspace.  As mentioned, putting them into sysfs would
violate the one value/one file rule.  The use of /proc is discouraged.
debugfs was mentioned, but I have never used it.  Noticed that debugfs
was enabled in the default config (at least for pseries).  Looks like
that would be the best alternative.  Agree?

-- 
Mike
