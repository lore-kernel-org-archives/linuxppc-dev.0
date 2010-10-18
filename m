Return-Path: <dgibson@ozlabs.org>
Date: Tue, 19 Oct 2010 01:14:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Parsing DTS file
Message-ID: <20101018141440.GA5512@yookeroo>
References: <201010181413.58302.dargaud@lpsc.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201010181413.58302.dargaud@lpsc.in2p3.fr>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 18, 2010 at 02:13:58PM +0200, Guillaume Dargaud wrote:
> Hello all,
> I'm sure there's a standard way of doing this: I'd like to access some info 
> from the DTS file from a usermode program (things like address of device, 
> etc...)
> What is the best way to do this ? Write a parser ? Or query the running kernel 
> somehow ?

Um.. this question doesn't seem to make a lot of sense.  What's the
context in which you're trying to do this.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
