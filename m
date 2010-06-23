Return-Path: <hpa@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73F82B6F29
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jun 2010 02:10:08 +1000 (EST)
Message-ID: <4C222D91.9030803@zytor.com>
Date: Wed, 23 Jun 2010 08:51:45 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 31/40] trace syscalls: Convert various generic compat
	syscalls
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
	<1277287401-28571-32-git-send-email-imunsie@au1.ibm.com>
	<4C21DFBA.2070202@linux.intel.com> <20100623102931.GB5242@nowhere>
	<4C21E3F8.9000405@linux.intel.com> <20100623113806.GD5242@nowhere>
In-Reply-To: <20100623113806.GD5242@nowhere>
Content-Type: text/plain; charset=UTF-8
Cc: Christoph Lameter <cl@linux-foundation.org>, WANG Cong <amwang@redhat.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>, Andi Kleen <ak@linux.intel.com>,
	Mike Frysinger <vapier.adi@gmail.com>,
	Eric Dumazet <eric.dumazet@gmail.com>,
	Jeff Moyer <jmoyer@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
	David Rientjes <rientjes@google.com>,
	Ingo Molnar <mingo@elte.hu>, Arnd Bergmann <arnd@arndb.de>,
	Steven Rostedt <rostedt@goodmis.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Roland McGrath <roland@redhat.com>,
	Lee Schermerhorn <lee.schermerhorn@hp.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Neil Horman <nhorman@tuxdriver.com>, linux-mm@kvack.org,
	netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	Simon Kagstrom <simon.kagstrom@netinsight.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2010 04:38 AM, Frederic Weisbecker wrote:
> 
> I haven't heard any complains about existing syscalls wrappers.
> 

Then you truly haven't been listening.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
