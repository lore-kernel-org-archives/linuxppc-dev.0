Date: Tue, 9 Jan 2001 08:24:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: "Zheng, Haifei" <haifei.zheng@intel.com>,
        "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: menuconfig for PPC860T
Message-ID: <20010109082428.D26544@opus.bloom.county>
References: <5D2136DF3DD5D311AE89009027C67FB001D8F265@fmsmsx96.fm.intel.com> <3A5A5F1C.DBD4425@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A5A5F1C.DBD4425@mvista.com>; from dan@mvista.com on Mon, Jan 08, 2001 at 07:45:16PM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jan 08, 2001 at 07:45:16PM -0500, Dan Malek wrote:

> > We downloaded kernel version 2.4.0 from kernel.org.
>
> That site is not properly updated with PowerPC patches.  We are
> actively working on that problem.  For now, please visit
> 	http://www.fsmlabs.com/linuxppcbk.html
>
> to get access to the latest 2.4 PowerPC Linux sources.

Also, if you are building this on a pentium, don't forget to do something
like make ARCH=ppc menuconfig.  The 8xx targets are known to build, and
should be working.  If you have to fix any problems, please send patches.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
