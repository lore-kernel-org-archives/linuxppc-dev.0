Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 19 Jul 2011 11:23:51 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Ayman El-Khashab <ayman@elkhashab.com>
Subject: Re: [v2 PATCH 1/1] powerpc/4xx: enable and fix pcie gen1/gen2 on the
	460sx
Message-ID: <20110719012351.GL20597@ozlabs.org>
References: <1310603611-8960-2-git-send-email-ayman@elkhashab.com>
	<1310748027-31956-1-git-send-email-aymane@elkhashab.com>
	<20110718040115.GK20597@ozlabs.org>
	<20110718133101.GB26701@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20110718133101.GB26701@crust.elkhashab.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 18, 2011 at 08:31:01AM -0500, Ayman El-Khashab wrote:

> Yes, but I think that is correct for it to be "1".  The data
> sheets for these parts that I checked had bit 1 marked as
> reserved.  Only OMR1MSKL and OMR3MSKL had extra definitions
> such as the _IO and _UOT.  The parts I checked which were
> the sheets for the EX and SX (which cover another 6 or 7
> parts) all had it with just a single bit defined on that
> register.

Ahh okay.  I kind of think that this may need to be a seperate change.  At the
very least it needs to be explicitly mentioned in the change log.

Yours Tony
