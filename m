Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 19AABB6F98
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 01:51:09 +1000 (EST)
Date: Tue, 5 Apr 2011 08:49:18 -0700
From: Greg KH <gregkh@suse.de>
To: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 00/34] Make kernel build deterministic
Message-ID: <20110405154918.GA31337@suse.de>
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
Cc: anil_ravindranath@pmc-sierra.com, mchehab@redhat.com, x86@kernel.org,
	mac@melware.de, aacraid@adaptec.com,
	linux-mtd@lists.infradead.org, allan.stephens@windriver.com,
	hpa@zytor.com, netdev@vger.kernel.org, t.sailer@alumni.ethz.ch,
	gwingerde@gmail.com, IvDoorn@gmail.com, elf@buici.com,
	cluster-devel@redhat.com, ccaulfie@redhat.com, mingo@redhat.com,
	dougthompson@xmission.com, linux-media@vger.kernel.org,
	arnaud.giersch@free.fr, linux-kbuild@vger.kernel.org,
	teigland@redhat.com, tony.olech@elandigitalsystems.com,
	apw@canonical.com, linux-hams@vger.kernel.org,
	tglx@linutronix.de, swhiteho@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	jon.maloy@ericsson.com, linux-scsi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	bluesmoke-devel@lists.sourceforge.net, James.Bottomley@suse.de,
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

On Tue, Apr 05, 2011 at 04:58:47PM +0200, Michal Marek wrote:
> 
> Hi,
> 
> this series makes it possible to build bit-identical kernel image and
> modules from identical sources. Of course the build is already
> deterministic in terms of behavior of the code, but the various
> timestamps embedded in the object files make it hard to compare two
> builds, for instance to verify that a makefile cleanup didn't
> accidentally change something. A prime example is /proc/config.gz, which
> has both a timestamp in the gzip header and a timestamp in the payload
> data. With this series applied, a script like this will produce
> identical kernels each time:

Very nice stuff.  Do you want to take the individual patches through one
of your trees, or do you mind if the subsystem maintainers take them
through theirs?

thanks,

greg k-h
