Return-Path: <mmarek@suse.cz>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25FC8B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 19:23:49 +1000 (EST)
Message-ID: <4D9C311C.4080008@suse.cz>
Date: Wed, 06 Apr 2011 11:23:40 +0200
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 00/34] Make kernel build deterministic
References: <1302015561-21047-1-git-send-email-mmarek@suse.cz>
	<20110405154918.GA31337@suse.de>
In-Reply-To: <20110405154918.GA31337@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
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

On 5.4.2011 17:49, Greg KH wrote:
> Very nice stuff.  Do you want to take the individual patches through one
> of your trees, or do you mind if the subsystem maintainers take them
> through theirs?

I'd leave it up to the subsystem maintainers. I'll check once the merge
window opens and send the remaining patches to Linus directly.

Michal
