In-Reply-To: <40B1FB42.1040306@intracom.gr>
References: <40A38968.6060701@intracom.gr> <40A4C04A.8060508@intracom.gr> <F8A7B640-A5F0-11D8-9559-003065F9B7DC@embeddededge.com> <40B1FB42.1040306@intracom.gr>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <505FCE42-ADA6-11D8-B485-003065F9B7DC@embeddededge.com>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>, Wolfgang Denk <wd@denx.de>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] Driver for FECs on motorola DUET (87x/88x)
Date: Mon, 24 May 2004 13:18:03 -0400
To: Pantelis Antoniou <panto@intracom.gr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On May 24, 2004, at 9:40 AM, Pantelis Antoniou wrote:

> Before I submerge into the assembly of head_8xx.S does anyone have any
> ideas?

I just used head.S, which works fine on the 82xx, as a model for the
code in head_8xx.S.  I've been looking at some "common" PPC cache
management functions that I'm not certain are doing the proper thing
on the 8xx.  I'm suspecting some data corruption problems due to
improper effects of cache instructions.

There are some optimizations we can do to head_8xx.S, but I don't
think there is anything incorrect in it.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
