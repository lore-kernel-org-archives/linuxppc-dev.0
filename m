Date: Wed, 26 Mar 2003 18:09:21 +0100
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: dcbz works on 862 everywhere!
In-reply-to: <3E81C5AA.80206@embeddededge.com>
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"Linuxppc-Embedded@Lists. Linuxppc. Org" <linuxppc-embedded@lists.linuxppc.org>,
	strauman@SLAC.Stanford.EDU
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLOEHKFLAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Joakim Tjernlund wrote:
>
> > I am still intrested in trying copy-on-write but I can't figure out
> > how. Is it a big job? Any pointers?
>
> The 8xx properly implements copy-on-write now.  I don't remember when
> I updated this, maybe somewhere in the mid 2.3.xxx timeframe.  All of
> the processor specific MM functions have to be changed, it isn't
> something that is likely going to be a configuration option. due to
> all of the common #define, macros, and page table functions.  It
> does remove three instructions and a branch from the TLBmiss handler :-)

Ahh, that explanins why I had such a hard time trying to find
where it didn't do copy-on-write :-)

 Thanks
         Jocke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
