Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5199167BB5
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 05:47:38 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7BJlJ96008918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 15:47:33 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7BJkmB9142962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 13:46:49 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7BJkmBl011257
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 13:46:48 -0600
Date: Fri, 11 Aug 2006 14:46:47 -0500
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/4]: powerpc/cell spidernet ethtool -i version number
	info.
Message-ID: <20060811194647.GO10638@austin.ibm.com>
References: <20060811180013.GB6550@pb15.lixom.net>
	<OF934FE4E3.EEC44FDD-ON872571C7.00668651-862571C7.00677A44@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OF934FE4E3.EEC44FDD-ON872571C7.00668651-862571C7.00677A44@us.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Arnd Bergmann <arnd@arndb.de>, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Olof,

Olof Johansson <olof@lixom.net> writes:
> On Fri, Aug 11, 2006 at 12:11:17PM -0500, Linas Vepstas wrote:
> 
> > This patch adds version information as reported by 
> > ethtool -i to the Spidernet driver.
> 
> Why does a driver that's in the mainline kernel need to have a version
> number besides the kernel version?

I'll let Jim be the primary defender. From what I can tell, "that's the
way its done".  For example:

linux-2.6.18-rc3-mm2 $ grep MODULE_VERSION */*/*.c |wc
     164     245    9081

> I can understand it for drivers like e1000 that Intel maintain outside
> of the kernel as well. But spidernet is a fully mainline maintained
> driver, right?

Yes, the spidernet is a Linux-kernel only driver.

--linas

p.s. very strange, but I did not see your original email;  
only saw Jim's reply.
