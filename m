MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16562.40219.697070.194257@cargo.ozlabs.ibm.com>
Date: Tue, 25 May 2004 11:10:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>, Wolfgang Denk <wd@denx.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] Driver for FECs on motorola DUET (87x/88x)
In-Reply-To: <505FCE42-ADA6-11D8-B485-003065F9B7DC@embeddededge.com>
References: <40A38968.6060701@intracom.gr>
	<40A4C04A.8060508@intracom.gr>
	<F8A7B640-A5F0-11D8-9559-003065F9B7DC@embeddededge.com>
	<40B1FB42.1040306@intracom.gr>
	<505FCE42-ADA6-11D8-B485-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> There are some optimizations we can do to head_8xx.S, but I don't
> think there is anything incorrect in it.

Given that the 860 manual says that the 860 sets DAR and DSISR on a
machine check, I think Joakim's patch is desirable.  I assume other
8xx processors do also.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
