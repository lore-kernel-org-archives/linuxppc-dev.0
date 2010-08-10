Return-Path: <david-b@pacbell.net>
Received: from n5-vm0.bullet.mail.gq1.yahoo.com
	(n5-vm0.bullet.mail.gq1.yahoo.com [67.195.8.62])
	by ozlabs.org (Postfix) with SMTP id EC437B6F0D
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 23:44:04 +1000 (EST)
Message-ID: <220473.37389.qm@web180310.mail.gq1.yahoo.com>
Date: Tue, 10 Aug 2010 06:44:03 -0700 (PDT)
From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH v2 4/6] mtd: m25p80: add a read
	function to read page by page
To: Mingkai Hu <Mingkai.hu@freescale.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTikM5je7Ckt=7bP6fj7OKCaroSn_AqgcS4T+Bv5d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=0A=0A--- On Tue, 8/10/10, Grant Likely <grant.likely@secretlab.ca> wrote:=
=0A=0A> This one bothers me, but I can't put my=0A> finger on it.=A0The fla=
g feels=0A> like a controller specific hack.=0A=0AThat's because it *IS* ..=
.=0A=0ANot clear what a good fix would look like.=0ABut in general, SPI mas=
ter controllers are=0Aresponsible for returning all bytes requested,=0Ainst=
ead of (as with this one) a subset.=0A=0ASuggesting the real issue is a bug=
gy SPI=0Amaster controller and/or driver.  Can't it=0Aissue multiple reads =
to collect all the data=0Arequested?? =0A=0A- Dave=0A=0A=0A
