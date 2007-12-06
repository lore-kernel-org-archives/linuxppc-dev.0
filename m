Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: More detailed testing of tree checks 
In-Reply-To: Your message of "Thu, 06 Dec 2007 16:56:55 +1100."
	<20071206055655.GC19927@localhost.localdomain>
References: <20071206055655.GC19927@localhost.localdomain> 
Date: Thu, 06 Dec 2007 09:20:06 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1J0IWE-00057t-3T@jdl.com>
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
> This patch modifies the dtc-checkfails.sh testcase wrapper so that
> instead of testing just that dtc fails with a particular error code on
> the sample input, it scans dtc's stderr output looking for a message
> that dtc failed a specific check or checks.  This has several advantages:
> 	- It means we more precisely check dtc's checking behaviour
> 	- It means we can check for generation of warnings using the
> same script
> 	- It means we can test cases where dtc should generate
> multiple errors or warnings from different checks
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
