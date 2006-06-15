Return-Path: <mkravetz@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6BFEB67B80
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jun 2006 00:58:27 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k5FEwOr8012052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 10:58:24 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k5FEwT4H107828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 08:58:29 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k5FEwN8u017544
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 08:58:23 -0600
Date: Thu, 15 Jun 2006 07:58:26 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060615145826.GA3461@monkey.ibm.com>
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614224040.GH26750@localdomain>
	<20060614235217.GA3876@monkey.ibm.com>
	<200606151309.40360.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <200606151309.40360.arnd@arndb.de>
Cc: Bryan Rosenburg <rosnbrg@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>, Paul Mackerras <paulus@samba.org>,
	Christopher Yeoh <cyeoh@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 15, 2006 at 01:09:39PM +0200, Arnd Bergmann wrote:
> On Thursday 15 June 2006 01:52, Mike Kravetz wrote:
> > I'm really wondering what would be the best way to make these stats
> > available to userspace.  As mentioned, putting them into sysfs would
> > violate the one value/one file rule.  The use of /proc is discouraged.
> > debugfs was mentioned, but I have never used it.  Noticed that debugfs
> > was enabled in the default config (at least for pseries).  Looks like
> > that would be the best alternative.  Agree?
> 
> Debugfs sounds good. If you use one file per hcall, it's probably as
> easy as

But does debugfs have the same one value/one file rule?  Thought I could
dump all the data in a single debugfs file.

-- 
Mike
