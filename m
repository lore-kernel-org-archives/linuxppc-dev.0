Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17348.50913.414568.263736@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jan 2006 19:50:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20060111071032.GA28843@gate.ebshome.net>
References: <17348.35120.840409.283964@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0601102238530.15824-100000@gate.crashing.org>
	<17348.37558.434652.697604@cargo.ozlabs.ibm.com>
	<20060111071032.GA28843@gate.ebshome.net>
Cc: linuxppc64-dev@ozlabs.org, Kumar Gala <galak@gate.crashing.org>,
	sjmunroe@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] implement AT_PLATFORM for powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eugene Surovegin writes:

> I checked 44x user manuals I have:
> 
> 440GP doesn't have isel
> 440GX, 440EP, 440SP, 440SPe, 440GR have it.

Thanks, that's helpful.  Do you know if 440{GX,EP,SP,SPe,GR} implement
all of the 32-bit user-mode instructions in Book E?

How do mbar and msync work on those processors?  As mbar and msync (as
defined in Book E) or as eieio and sync?

Do the 440* processors in fact claim Book E compliance?

Thanks,
Paul.
