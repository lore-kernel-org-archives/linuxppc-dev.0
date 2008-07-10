Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: powerpc/cell/cpufreq: add spu aware cpufreq governor
Date: Thu, 10 Jul 2008 23:05:08 +0200
References: <200807071702.31240.arnd@arndb.de>
	<20080708152728.GF4997@codemonkey.org.uk>
	<20080710180553.GB13890@isilmar.linta.de>
In-Reply-To: <20080710180553.GB13890@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807102305.08752.arnd@arndb.de>
Cc: Dave Jones <davej@codemonkey.org.uk>,
	Stephen Rothwell <sfr@canb.auug.org.au>, cpufreq@lists.linux.org.uk,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Jeremy Kerr <jk@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 July 2008, Dominik Brodowski wrote:
> Actually, "cpufreq-set -g spu_governor" should be enough. (BTW, do we really
> want this name?)

Do you have a better suggestion for the name? I don't think there was a
particularly strong reason to choose it over something else.

	Arnd <><
