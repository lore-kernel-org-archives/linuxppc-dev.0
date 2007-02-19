Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17880.61080.644756.499806@cargo.ozlabs.ibm.com>
Date: Mon, 19 Feb 2007 11:26:00 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/3] zImage: Cleanup and improve zImage entry point
In-Reply-To: <20070218072310.GB1859@localhost.localdomain>
References: <20070216062739.6DFDBDDD05@ozlabs.org>
	<45D7AA50.3090408@am.sony.com>
	<20070218072310.GB1859@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson writes:

> Err... isn't the called function responsible for setting up its own
> stack frame if necessary.  I thought all that was needed was for r1 to
> point to some free space.

The called function stores its return address in the caller's stack
frame.  So r1 does need to point to a stack frame.

Paul.
