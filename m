Return-Path: <mkravetz@us.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5CAC67B82
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 10:06:24 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6F06LT7009467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 20:06:21 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6F06LmI311646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 18:06:21 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6F06Lhq028797
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 18:06:21 -0600
Date: Fri, 14 Jul 2006 17:06:24 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls
Message-ID: <20060715000624.GH6824@monkey.ibm.com>
References: <20060714233739.GA11487@monkey.ibm.com>
	<200607150200.03494.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200607150200.03494.arnd@arndb.de>
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

On Sat, Jul 15, 2006 at 02:00:02AM +0200, Arnd Bergmann wrote:
> What happened to the question whether to use PURR values for also measuring
> cycles spent executing the hcall as opposed to cycles that passed before
> the hcall returns. Did that turn out not giving extra information after all
> or was there a different reason to drop that idea?

Oops, forgot that as an additional issue/question.  In this patch, I went
back to mftb() as 'wall time' made more sense for the group wanting this
functionality.  It is easy to switch, or collect both (I think).  Since I
started with mftb went to PURR and then back to mftb, it certainly does
look like an agument to try and collect both. :)

-- 
Mike
