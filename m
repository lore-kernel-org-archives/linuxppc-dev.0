Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18742.20121.759577.660481@cargo.ozlabs.ibm.com>
Date: Wed, 3 Dec 2008 20:17:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: Re: [patch 1/1] hvc_console: fix: hp->ws winsize check runs
	out-of-sync
In-Reply-To: <20081118113848.945650506@linux.vnet.ibm.com>
References: <20081118112827.927627788@linux.vnet.ibm.com>
	<20081118113848.945650506@linux.vnet.ibm.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PPC devel <linuxppc-dev@ozlabs.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hendrik Brueckner writes:

> From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> 
> The test to check for a new winsize runs out-of-sync with the underlying
> tty. After a tty has been released and initialized again, the winsize might
> differ between the tty and the hp struct. 
> The solution is to simply remove the check and always schedule the resize work.

Looks OK.  Is this going to go in via the s390 tree, or should I put
it in the powerpc tree?

Paul.
