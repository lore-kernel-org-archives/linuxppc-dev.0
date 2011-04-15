Return-Path: <nacc@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 26E7BB6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 07:01:37 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3FKp0oG002368
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 16:51:00 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3FL11Xa166762
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 17:01:06 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3FL1069029236
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 15:01:01 -0600
Date: Fri, 15 Apr 2011 14:00:51 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix kexec-related UP build error
Message-ID: <20110415210051.GA31245@us.ibm.com>
References: <20110415202916.GA6758@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110415202916.GA6758@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On 15.04.2011 [13:29:16 -0700], Paul E. McKenney wrote:
> Hello!
> 
> The following patch fixes a UP build problem for kexec() on powerpc.
> When the crash_kexec_wait_realmode() function was added, it was
> placed in only two of the three required locations.

I believe the fix has already been posted as

http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-April/089559.html

Thanks,
Nish 
