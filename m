Return-Path: <akpm@linux-foundation.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B8460B6F2B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 10:06:40 +1000 (EST)
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21912DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 10:06:39 +1000 (EST)
Date: Fri, 21 Aug 2009 17:06:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Amerigo Wang <amwang@redhat.com>
Subject: Re: [Patch 0/8] V4 Implement crashkernel=auto
Message-Id: <20090821170615.1ea4a4f4.akpm@linux-foundation.org>
In-Reply-To: <20090821065637.4855.32234.sendpatchset@localhost.localdomain>
References: <20090821065637.4855.32234.sendpatchset@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: fenghua.yu@intel.com, nhorman@redhat.com, tony.luck@intel.com,
	linux-ia64@vger.kernel.org, amwang@redhat.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	andi@firstfloor.org, ebiederm@xmission.com, mingo@elte.hu,
	bernhard.walle@gmx.de, kamezawa.hiroyu@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(cc linuxppc-dev@ozlabs.org)

On Fri, 21 Aug 2009 02:54:12 -0400
Amerigo Wang <amwang@redhat.com> wrote:

> This series of patch implements automatically reserved memory for crashkernel,
> by introducing a new boot option "crashkernel=auto". This idea is from Neil.
> 
> In case of breaking user-space applications, it modifies this boot option after
> it decides how much memory should be reserved.
> 
> On different arch, the threshold and reserved memory size is different. Please
> refer patch 8/8 which contains an update for the documentation.
> 
> Patch 1/8 implements shrinking reserved memory at run-time, which is useful
> when more than enough memory is reserved automatically.
> 
> Note: This patchset was only tested on x86_64 with differernt memory sizes.


I'd prefer that this change had been runtime tested on ia64 and powerpc
and has had some quality review from relevant developers of those
architectures.

Looking at the cc's, I'm not sure that the powerpc guys even know about
this work?
