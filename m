Date: Wed, 15 May 2002 14:41:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bitkeeper question
Message-ID: <20020515214120.GB20456@opus.bloom.county>
References: <45B36A38D959B44CB032DA427A6E10640167CFCE@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167CFCE@cceexc18.americas.cpqcorp.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 15, 2002 at 02:34:54PM -0500, Cameron, Steve wrote:

> I'm not sure if this is the right place
> to ask.  I'm wondering about how (and if) tags
> are being used for the bk://ppc.bkserver.net/linuxppc_2_4_devel
> tree.

The only tags on that repository are the kernel.org tags.  IE:
bk export -rv2.4.18
Will get you kernel.org as of 2.4.18.   If you do some looking w/ bk
changes, you can see when that was merged into the repository, and
export that changeset.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
