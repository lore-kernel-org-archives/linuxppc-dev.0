Return-Path: <mkravetz@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C1AF67B5B
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jun 2006 13:48:01 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5E3lwv0002188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 23:47:58 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5E3m3wc079590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 21:48:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5E3lwuR004141
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 21:47:58 -0600
Date: Tue, 13 Jun 2006 20:47:56 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060614034756.GA6759@monkey.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch series adds instrumentation to Hypervisor calls.  Code and
ideas were taken from the patch set provided by Christopher Yeoh.

The idea is to put all instrumentation code behind a configuration
option so that it can easily be added/removed.  The instrumentation
code is kept to a minimum in the hopes that it's impact to performance
will not be noticed.  Statistics are made available via files in sysfs.

-- 
Mike
