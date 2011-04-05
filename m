Return-Path: <James.Bottomley@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id B7625B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 04:17:11 +1000 (EST)
Subject: Re: [PATCH 00/34] Make kernel build deterministic
From: James Bottomley <James.Bottomley@suse.de>
To: Greg KH <gregkh@suse.de>
In-Reply-To: <20110405154918.GA31337@suse.de>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
	<20110405154918.GA31337@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 05 Apr 2011 11:16:52 -0700
Message-ID: <1302027412.2924.7.camel@mulgrave.site>
Mime-Version: 1.0
Cc: anil_ravindranath@pmc-sierra.com, mchehab@redhat.com, x86@kernel.org,
	mac@melware.de, aacraid@adaptec.com,
	linux-mtd@lists.infradead.org, allan.stephens@windriver.com,
	hpa@zytor.com, netdev@vger.kernel.org, t.sailer@alumni.ethz.ch,
	gwingerde@gmail.com, IvDoorn@gmail.com, elf@buici.com,
	cluster-devel@redhat.com, ccaulfie@redhat.com, mingo@redhat.com,
	dougthompson@xmission.com, linux-media@vger.kernel.org,
	jon.maloy@ericsson.com, arnaud.giersch@free.fr,
	linux-kbuild@vger.kernel.org, teigland@redhat.com,
	tony.olech@elandigitalsystems.com, apw@canonical.com,
	linux-hams@vger.kernel.org, tglx@linutronix.de,
	swhiteho@redhat.com, linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
	linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
	tipc-discussion@lists.sourceforge.net, chuanxiao.dong@intel.com,
	paulus@samba.org, dwmw2@infradead.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-04-05 at 08:49 -0700, Greg KH wrote:
> On Tue, Apr 05, 2011 at 04:58:47PM +0200, Michal Marek wrote:
> > 
> > Hi,
> > 
> > this series makes it possible to build bit-identical kernel image and
> > modules from identical sources. Of course the build is already
> > deterministic in terms of behavior of the code, but the various
> > timestamps embedded in the object files make it hard to compare two
> > builds, for instance to verify that a makefile cleanup didn't
> > accidentally change something. A prime example is /proc/config.gz, which
> > has both a timestamp in the gzip header and a timestamp in the payload
> > data. With this series applied, a script like this will produce
> > identical kernels each time:
> 
> Very nice stuff.  Do you want to take the individual patches through one
> of your trees, or do you mind if the subsystem maintainers take them
> through theirs?

I'm happy for this to go through a single tree.

James
