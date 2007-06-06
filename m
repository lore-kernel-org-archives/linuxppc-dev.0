Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18022.20173.857845.49576@cargo.ozlabs.ibm.com>
Date: Wed, 6 Jun 2007 16:06:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH] powerpc: Add Marvell mv64x60 udbg putc/getc functions
In-Reply-To: <20070523220518.GA2312@xyzzy.farnsworth.org>
References: <20070523220518.GA2312@xyzzy.farnsworth.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dale Farnsworth writes:

> Paul, this patch is unchanged from the one I posted 10 days ago.
> At that time, I saw no discussion, other than Mark's ACK.  I'd 
> argue that this is a bugfix, and hope that it could go into 2.6.22.

Um, it seems rather large, and in particular adds a fair bit of
completely new code.  Is there a simpler way of getting to an
acceptable point - e.g. just not use the udbg console on these boards?
If we don't have udbg support for them then the udbg console would
seem a bit pointless, no?

Paul.
