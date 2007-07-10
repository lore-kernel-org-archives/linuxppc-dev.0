Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18067.23198.856592.39397@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jul 2007 20:08:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Infinite loop/always true check possible with unsigned
	counter.
In-Reply-To: <jewsx8fuqk.fsf@sykes.suse.de>
References: <469270F3.4070206@austin.ibm.com> <46928691.2040008@austin.ibm.com>
	<18066.53384.449544.952545@cargo.ozlabs.ibm.com>
	<je1wfgh9qj.fsf@sykes.suse.de>
	<18067.22066.466767.663198@cargo.ozlabs.ibm.com>
	<jewsx8fuqk.fsf@sykes.suse.de>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab writes:

> >> ??? There is no rgn->cnt involved in the comparison.
> >
> > Look further down in lmb_add_region; there is a second for loop that
> > does
> >
> > 	for (i = rgn->cnt-1; i >= 0; i--)
> 
> Which is exactly the one quoted above.  I still don't see your point.

You're right - my mistake.

Paul.
