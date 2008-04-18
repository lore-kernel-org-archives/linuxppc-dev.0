Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18440.16870.977737.279043@cargo.ozlabs.ibm.com>
Date: Fri, 18 Apr 2008 16:38:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.25-mm1 on the g5
In-Reply-To: <20080417224248.fdd89284.akpm@linux-foundation.org>
References: <20080417224248.fdd89284.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> It had been running happily and hard for a couple of hours when:

Looks like the bug that Kamalesh Babulal reported and which I have
been chasing without success so far.

> That's a pretty crappy trace.  Perhaps netconsole lost some of it, dunno.

Yeah, there's a bug in the handling of that particular error condition
which I have a patch to fix.

Paul.
