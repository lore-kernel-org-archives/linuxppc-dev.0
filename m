Return-Path: <bbrv@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCC6B67A5B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 01:01:55 +1000 (EST)
In-Reply-To: <E1Ftmcb-0007rG-QS@jdl.com>
References: <01ca01c696cd$2e453f30$99dfdfdf@bakuhatsu.net>
	<E1Ftmcb-0007rG-QS@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E11A25FA-3D47-49E6-8EBB-15A64C81C9C7@genesi-usa.com>
From: Raquel Velasco and Bill Buck <bbrv@genesi-usa.com>
Subject: Re: cpu power "management" for non-dfs chips with no pmu (for
	instance, 750cxe and mpc7447 in pegasos)
Date: Fri, 23 Jun 2006 09:38:07 -0500
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon, we appreciate the effort that you, Kate and Becky are making. ;-)
R&B
On Jun 23, 2006, at 9:26 AM, Jon Loeliger wrote:

> So, like, the other day "Matt Sealey" mumbled:
>>
>> I have nothing real to contribute other than I would like to see  
>> it :)
>
> Disbelief.  :-)
>
>> Before I asked I checked Google (as is expected of anyone these days)
>> and found some discussions on debian-powerpc from 2002 but nobody
>> really did anything and nothing really came of it. I know 4 years  
>> later
>> all we have is powernowd which pokes up cpufreq which only supports
>> DFS and certain kinds of Mac PMU.
>
> Which is why it is all being revitalized now... :-)
> There was a mini symposium a couple months ago that started
> a few working groups to help kick start this back into viability.
>
>> ICTC is such a simple thing to support and you can slow down the CPU
>> pretty comprehensively (from halving to 255x in theory) with an on  
>> and
>> off flag. I am surprised nobody implemented a cpufreq governer  
>> even if
>> it is totally useless and gives no perceivable benefits..
>
> See?  You _are_ contributing already.  I encourage
> you to hit the linux-pm@lists.osdl.org list for a spell!
>
> You could start here:
> 	https://lists.osdl.org/mailman/listinfo/linux-pm
>
> Thanks,
> jdl
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
