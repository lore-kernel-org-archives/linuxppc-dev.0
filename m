Message-ID: <3E8B5D37.4090706@embeddededge.com>
Date: Wed, 02 Apr 2003 16:59:19 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Matt Porter <porter@cox.net>,
	Jean-Denis Boyer <jdboyer@mediatrix.com>,
	kas turi <inox_kas@yahoo.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling data cache
References: <2702075D4DE2B043BF5EB82E9CFAD45B763543@mail1.mediatrix.com> <20030402094037.A31751@home.com> <3E8B3895.5050908@embeddededge.com> <20030402194622.GA30107@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> My guess and recollection is that the 8260 version of this was to
> disable the DCACHE in a certain manner, because of buggy silicon on a
> specific board.  Someone unmerged this bit of code later I think.

Hmm....OK.  FYI, on any processor core except 8xx you can't disable
the data cache and expect to make any progress without also removing
the cache management instructions.  That would be a pretty ugly patch
and also require unique libraries for the applications. :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
