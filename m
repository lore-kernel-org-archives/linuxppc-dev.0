Return-Path: <gxt@mprc.pku.edu.cn>
Received: from mprc.pku.edu.cn (mprc.pku.edu.cn [162.105.203.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A549B6FFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Apr 2011 18:53:38 +1000 (EST)
From: "Guan Xuetao" <gxt@mprc.pku.edu.cn>
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>,
	"'LKML'" <linux-kernel@vger.kernel.org>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
	<201104172313.45854.rjw@sisk.pl>
In-Reply-To: <201104172313.45854.rjw@sisk.pl>
Subject: RE: [PATCH 12/14] PM / UNICORE32: Use struct syscore_ops instead of
	sysdevs for PM
Date: Tue, 19 Apr 2011 16:02:55 +0800
Message-ID: <006201cbfe68$3ad01380$b0703a80$@mprc.pku.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Cc: 'Kevin Hilman' <khilman@ti.com>,
	'Jeremy Fitzhardinge' <jeremy.fitzhardinge@citrix.com>,
	'Russell King' <linux@arm.linux.org.uk>,
	'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>,
	'Greg KH' <gregkh@suse.de>, 'Ralf Baechle' <ralf@linux-mips.org>,
	'Ben Dooks' <ben-linux@fluff.org>, 'Jiri Kosina' <jkosina@suse.cz>,
	'Kay Sievers' <kay.sievers@suse.de>, 'Mike Frysinger' <vapier@gentoo.org>,
	'Linux PM mailing list' <linux-pm@lists.linux-foundation.org>,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	'Hans-Christian Egtvedt' <hans-christian.egtvedt@atmel.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> Sent: Monday, April 18, 2011 5:14 AM
> To: LKML
> Cc: Greg KH; Kay Sievers; Linux PM mailing list; Russell King; linux-omap@vger.kernel.org; Kevin Hilman; linux-arm-
> kernel@lists.infradead.org; Ben Dooks; Mike Frysinger; Ralf Baechle; Hans-Christian Egtvedt; Guan Xuetao; Benjamin Herrenschmidt;
> linuxppc-dev@lists.ozlabs.org; Jiri Kosina; Konrad Rzeszutek Wilk; Jeremy Fitzhardinge
> Subject: [PATCH 12/14] PM / UNICORE32: Use struct syscore_ops instead of sysdevs for PM
> 
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Make some UNICORE32 architecture's code use struct syscore_ops
> objects for power management instead of sysdev classes and sysdevs.
> 
> This simplifies the code and reduces the kernel's memory footprint.
> It also is necessary for removing sysdevs from the kernel entirely in
> the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
