Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17961.22721.462194.785356@cargo.ozlabs.ibm.com>
Date: Sat, 21 Apr 2007 10:20:17 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Change 440GP platform to ppc440
In-Reply-To: <Pine.LNX.4.64.0704191615040.25069@localhost.localdomain>
References: <Pine.LNX.4.64.0704191615040.25069@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> I don't see any reason the 440GP should its own platform.  Posting this to
> see if anyone thinks otherwise.

I recall dimly that there was some user-visible difference between the
440GP and the other 440 processors, and that's why we made the
platform string different.  I don't recall what the difference was.

Paul.
