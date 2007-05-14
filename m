Return-Path: <scottwood@freescale.com>
Message-ID: <46488597.5060109@freescale.com>
Date: Mon, 14 May 2007 10:51:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [DTC PATCH] Remove overreaching semantic tests.
References: <20070511175553.GA14692@ld0162-tx32.am.freescale.net>
	<20070514011915.GH6517@localhost.localdomain>
In-Reply-To: <20070514011915.GH6517@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Fri, May 11, 2007 at 12:55:54PM -0500, Scott Wood wrote:
>>I wouldn't be opposed to keeping these tests around if there were a
>>command line option that cleanly separates the errors/warnings into
>>classes such as structural, semantic-missing, semantic-broken, etc.
> 
> Exactly - which is why I really don't want to simply tear out this
> checking code.  I've never gotten around to reworking the
> error/warning system so it can sensibly divide things into such
> classes, and keep detecting further warnings after picking up some
> non-fatal ones and so forth.
> 
> I'd much prefer you just disable these tests for now, either by
> commenting code out, or removing calls to checking functions.  That
> will make it easier to optionally reinstate later.

Well, I figured the code would still be there in git, so getting it back 
wouldn't be too hard.  I can submit a patch that hides it behind a 
--warn-missing (or whatever) option, though.

-Scott
