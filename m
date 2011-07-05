Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9F945B6F7A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 08:36:29 +1000 (EST)
Message-ID: <4E1391C2.2090904@zytor.com>
Date: Tue, 05 Jul 2011 15:35:46 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC] virtio: expose for non-virtualization users too
References: <1309874774-31689-1-git-send-email-ohad@wizery.com>
In-Reply-To: <1309874774-31689-1-git-send-email-ohad@wizery.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Carsten Otte <cotte@de.ibm.com>, linux-ia64@vger.kernel.org,
	kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	virtualization@lists.linux-foundation.org,
	Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, x86@kernel.org, Alexander Graf <agraf@suse.de>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Avi Kivity <avi@redhat.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	Xiantao Zhang <xiantao.zhang@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Rusty Russell <rusty@rustcorp.com.au>, Chris Metcalf <cmetcalf@tilera.com>,
	John Stultz <john.stultz@linaro.org>, kvm-ppc@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tony Luck <tony.luck@intel.com>, kvm-ia64@vger.kernel.org,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2011 07:06 AM, Ohad Ben-Cohen wrote:
> virtio has been so far used only in the context of virtualization,
> and the virtio Kconfig was sourced directly by the relevant arch
> Kconfigs when VIRTUALIZATION was selected.
> 
> Now that we start using virtio for inter-processor communications,
> we need to source the virtio Kconfig outside of the virtualization
> scope too.
> 

Seems reasonable to me.

	-hpa
