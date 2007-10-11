Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DEA2DE05C
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Oct 2007 07:43:02 +1000 (EST)
Date: Thu, 11 Oct 2007 16:42:51 -0500 (CDT)
Message-Id: <200710112142.l9BLgp6U031283@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Subject: Re: [PATCH v2] powerpc: don't enable cpu hotplug on mpic-based pseries
In-Reply-To: <18189.47620.466515.645055@cargo.ozlabs.ibm.com>
References: <20071008180406.052382073@mini.kroah.org>,
	<20071008180633.GJ7627@kroah.com>,
	<20071009151702.GA19209@lixom.net>,
	<20071009222003.GA21228@kroah.com>,
	<alpine.LFD.0.9999.0710100120340.7766@localhost.localdomain>,
	<alpine.LFD.0.999.0710091625520.3838@woody.linux%foundation.org>,
	<20071010000815.GB7875@lixom.net>,
	<20071010101826.186f1f24.sfr@canb.auug.org.au>,
	<20071010003824.GA8477@lixom.net>,
	<18189.47620.466515.645055@cargo.ozlabs.ibm.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras writes:
> Olof Johansson writes:
>> Don't allow cpu hotplug on systems lacking XICS interrupt controller,
>> since current code is hardcoded for it.
> ...
>> +	for (np = NULL; (np = of_find_node_by_name(np,
>> +						   "interrupt-controller"));) {
> 
> Looks like for_each_node_by_name would be nicer here.
> 
> If you agree, I'll hand-edit your patch to do that and apply it.  Of
> course, ultimately we should implement the necessary mpic bits to
> support cpu hotplug.
> 

While you are editing, can you please change the condition to finding
ppc-xicp instead of not finding open-pic?

thanks.
milton
