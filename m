Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4BB8967BE3
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 03:56:24 +1100 (EST)
In-Reply-To: <1162657000.3139.108.camel@vader.jdub.homelinux.org>
References: <1162632114.28571.33.camel@localhost.localdomain>
	<1162657000.3139.108.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BE9B9CEF-771F-44F7-AEF6-8B3CDE3DDB57@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FSL vs. IBM BookE
Date: Sat, 4 Nov 2006 10:56:17 -0600
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Cc: Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@gate.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 4, 2006, at 10:16 AM, Josh Boyer wrote:

> On Sat, 2006-11-04 at 20:21 +1100, Benjamin Herrenschmidt wrote:
>> Out of curiosity... I noticed we have both head_44x.S and
>> head_fsl_booke.S, the later being a fork of the former with  
>> changed from
>> Kumar (and possibly others) to support E200 and E500.
>>
>> How bad are the differences between those cores ? Would it be  
>> possible
>> to reconcile those and IBM 44x into a single processor family ? Or  
>> are
>> there some fundamental differences making that impossible ? (even  
>> with a
>> bit of CPU feature patching).
>
> I'm not sure.  Maybe Kumar knows better since he made the changes to
> head_fsl_booke.S.  I believe FSL can do SMP and has an SPE and some
> other HID registers that 44x does not have.

The big differences are in MMU architectures/programming models  
between 44x and FSL Book-E.  I tried to move as much common code into  
macros between the two head_* files.

- kumar
