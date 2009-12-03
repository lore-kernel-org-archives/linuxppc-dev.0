Return-Path: <arun@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp07.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 348B7B7C18
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 17:33:10 +1100 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp07.in.ibm.com (8.14.3/8.13.1) with ESMTP id nB36X83v030674
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 12:03:08 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB36X7qo2383900
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 12:03:08 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB36X7wD028133
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 17:33:07 +1100
Date: Thu, 3 Dec 2009 12:03:05 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [v10 PATCH 9/9]: POWER: Enable default_idle when power_save=off
Message-ID: <20091203063305.GA30923@linux.vnet.ibm.com>
References: <20091202095427.GA27251@linux.vnet.ibm.com>
	<20091202100346.GJ27251@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20091202100346.GJ27251@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-12-02 15:33:46]:

Thanks for running checkpatch on the patch Daniel. Will fix this.

arun
