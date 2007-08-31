Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Make make print a message when linking testcases 
In-Reply-To: Your message of "Fri, 31 Aug 2007 16:04:27 +1000."
	<20070831060427.GB29721@localhost.localdomain>
References: <20070831060427.GB29721@localhost.localdomain> 
Date: Fri, 31 Aug 2007 08:38:32 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IR6hk-0002gl-H4@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> Currently, dtc relies on make's implicit rule to build the testcases.
> This means that when not making verbosely (V=0, the default) there is
> no message at all while relinking the testsuites.  This can be very
> confusing when updating libfdt.a (upon which the testcases depend) and
> make appears to do nothing.
> 
> This patch corrects the situation, borrowing the rule used to link dtc
> itself to link all the testcases as well.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
