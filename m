Message-ID: <3DF754CE.7030608@intracom.gr>
Date: Wed, 11 Dec 2002 17:07:58 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: joakim.tjernlund@lumentis.se, acurtis@directvinternet.com,
	Dan Malek <dan@embeddededge.com>,
	Paul Mackerras <paulus@au1.ibm.com>, Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Regarding consistent_alloc
References: <IGEFJKJNHJDCBKALBJLLAELIFIAA.joakim.tjernlund@lumentis.se> <3DF70C55.3010709@intracom.gr> <20021211145658.GA19456@opus.bloom.county>
In-Reply-To: <20021211145658.GA19456@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

>On Wed, Dec 11, 2002 at 11:58:45AM +0200, Pantelis Antoniou wrote:
>
>[snip]
>
>>I think it's safe to assume that there is large amount of confussion at
>>this subject.
>>
>
>Definatly.
>
;)

>
>>FWIW I dislike the use of iopa(), and I would be forced to duplicate the
>>code of
>>consistent_alloc() class of functions in my tree.
>>
>
>Why would you have to duplicate the consistent_alloc code?  It is not
>tied to PCI, really.
>
Let's just say it's aesthetically unpleasent.
Since it is not tied to PCI anyway, what is the point
muddling it with it?

Perhaps the best way to proceed is just to fix the xxx_cpm_hostalloc() and
xxx_cpm_dpalloc() routines to work more intelligently, and to
forget about consistent_alloc entirely...

Regards

--
Pantelis Antoniou
INTRACOM S.A. Greece


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
