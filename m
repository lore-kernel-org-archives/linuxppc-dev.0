Date: Tue, 27 Aug 2002 17:23:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Allen Curtis <acurtis@onz.com>
Cc: dan@embeddededge.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260/8xx Embedded Boot patch
Message-ID: <20020828002353.GB22875@opus.bloom.county>
References: <200208271706.51677.acurtis@onz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200208271706.51677.acurtis@onz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 27, 2002 at 05:06:51PM -0700, Allen Curtis wrote:

> Fix/cleanup to embedded boot

The first thing I saw was the define_bool CONFIG_ALL_PPC n.
If this was actually needed someplace, there's a bug there that needs to
be fixed.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
