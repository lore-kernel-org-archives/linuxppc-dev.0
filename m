Message-ID: <3E81C5AA.80206@embeddededge.com>
Date: Wed, 26 Mar 2003 10:22:18 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: joakim.tjernlund@lumentis.se
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc.  Org" <linuxppc-embedded@lists.linuxppc.org>,
	strauman@SLAC.Stanford.EDU
Subject: Re: dcbz works on 862 everywhere!
References: <IGEFJKJNHJDCBKALBJLLAEHCFLAA.joakim.tjernlund@lumentis.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Joakim Tjernlund wrote:

> I am still intrested in trying copy-on-write but I can't figure out
> how. Is it a big job? Any pointers?

The 8xx properly implements copy-on-write now.  I don't remember when
I updated this, maybe somewhere in the mid 2.3.xxx timeframe.  All of
the processor specific MM functions have to be changed, it isn't
something that is likely going to be a configuration option. due to
all of the common #define, macros, and page table functions.  It
does remove three instructions and a branch from the TLBmiss handler :-)


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
