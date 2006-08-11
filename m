Return-Path: <linas@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 367B867BCF
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 03:18:49 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7BHIeNK027877
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 13:18:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7BHIeGa295714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 13:18:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7BHIeNK030921
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 13:18:40 -0400
Date: Fri, 11 Aug 2006 12:18:39 -0500
To: Milton Miller <miltonm@bga.com>
Subject: Re: Reg. Serial and Virtual consoles
Message-ID: <20060811171839.GM10638@austin.ibm.com>
References: <3115522870674b0dc514.719885386.miltonm@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3115522870674b0dc514.719885386.miltonm@bga.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 10, 2006 at 11:51:46AM -0500, Milton Miller wrote:
> It sounds to me that you want all input and output on the serial line to be echoed to  the vga screen both user and kernel.  Do you also require keyboard input?

I missed the start of the conversation, so the following suggestion may
be irrelevent. However, if the goal is to get kernel messages displayed
in lots of different places, this is easily done by running syslogd, and
adding the following to /etc/syslog.conf:

kern.*;*.err      *

If you don' want them slatered everywhere, but only on 
the console, then:

kern.*;*.err      |/dev/console

--linas
