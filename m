Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2350B6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 07:08:25 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3FKuDuS017648
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 14:56:13 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3FL8Kwu125908
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 15:08:20 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3FL8KKQ003135
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 15:08:20 -0600
Date: Fri, 15 Apr 2011 14:08:19 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] powerpc: Fix kexec-related UP build error
Message-ID: <20110415210819.GE2283@linux.vnet.ibm.com>
References: <20110415202916.GA6758@linux.vnet.ibm.com>
	<20110415210051.GA31245@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110415210051.GA31245@us.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 15, 2011 at 02:00:51PM -0700, Nishanth Aravamudan wrote:
> Hi Paul,
> 
> On 15.04.2011 [13:29:16 -0700], Paul E. McKenney wrote:
> > Hello!
> > 
> > The following patch fixes a UP build problem for kexec() on powerpc.
> > When the crash_kexec_wait_realmode() function was added, it was
> > placed in only two of the three required locations.
> 
> I believe the fix has already been posted as
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-April/089559.html

So it has!  Thank you for the pointer.

							Thanx, Paul
