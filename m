Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 403C3DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 12:13:55 +1000 (EST)
Message-ID: <46BBC9D9.8030608@am.sony.com>
Date: Thu, 09 Aug 2007 19:13:45 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	Jon Loeliger <jdl@jdl.com>
Subject: Re: DTC 1.0.0 Release Coming?
References: <E1IDjSy-0003eC-T4@jdl.com>	<20070726030550.GA1149@localhost.localdomain>	<E1IE314-0000qF-5x@jdl.com>	<20070726142739.GB18684@localhost.localdomain>	<E1IE59h-0001tt-JE@jdl.com>	<20070727013331.GB1561@localhost.localdomain>	<20070806084813.5432ba91@weaponx.rchland.ibm.com>
	<20070810013001.GF17370@localhost.localdomain>
In-Reply-To: <20070810013001.GF17370@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
>> Except didn't you say you were going to work with Stephen to get DTC
>> into the kernel source itself?  Keeping things similar to Kbuild might
>> help in that effort.
> 
> Actually, after discussions with Stephen and Paulus, we decided not to
> take this route.


Could you please let us know what was discussed, and what was proposed to
solve the problem of build failures when dtc is not installed?

-Geoff
