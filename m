Message-ID: <3BF5B94C.2000404@embeddededge.com>
Date: Fri, 16 Nov 2001 20:11:40 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
References: <20011116164625.K673@zax> <3BF542D4.10706@embeddededge.com> <20011117114724.H12763@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:



> ..........  create a new ppc4xx.c which
> will probably have a lot of code copied out of ppc4xx_setup.c,

Oh great, even more new files names......

> Gradually move each of the other 4xx machines over to the new scheme
> and finally remove ppc4xx_setup.c

How about you just do them all at once so we don't have a mess with
some old and some new methods?  Even if you can't test the changes,
contact someone that can and offer to do the best at changes.  Nothing
is worse than making major changes to only some of the files, leaving
someone else to do the remainder when they are busy trying to accomplish
something else.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
