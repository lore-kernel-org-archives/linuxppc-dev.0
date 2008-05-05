Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18462.27991.229693.188377@cargo.ozlabs.ibm.com>
Date: Mon, 5 May 2008 12:13:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Sean MacLennan <seanm@seanm.ca>
Subject: Re: WARNING: mutexes are preferred for single holder semaphores
In-Reply-To: <20080504204104.7eea7618@lappy.seanm.ca>
References: <20080504204104.7eea7618@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan writes:

> This is a bit OT, but I got the warning in the subject from
> checkpatch.pl for a piece of code. The code *is* using a mutex. Does it
> actually mean I shouldn't use a mutex?

I don't require zero checkpatch warnings or errors on patches before I
accept them.  If what checkpatch is saying is rubbish, just ignore it.

Paul.
