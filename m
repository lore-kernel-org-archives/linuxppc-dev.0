Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id 4A2B4B7D68
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 22:02:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Takuya Yoshikawa <yoshikawa.takuya@oss.ntt.co.jp>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit
	offset macro
Date: Mon, 10 May 2010 14:01:51 +0200
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com>
	<201005061538.54326.arnd@arndb.de> <4BE7F22E.9070504@oss.ntt.co.jp>
In-Reply-To: <4BE7F22E.9070504@oss.ntt.co.jp>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201005101401.52182.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
	kvm-ia64@vger.kernel.org, fernando@oss.ntt.co.jp,
	mtosatti@redhat.com, agraf@suse.de, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	mingo@redhat.com, paulus@samba.org, Avi Kivity <avi@redhat.com>,
	hpa@zytor.com, tglx@linutronix.de,
	Takuya Yoshikawa <takuya.yoshikawa@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 10 May 2010, Takuya Yoshikawa wrote:
> (2010/05/06 22:38), Arnd Bergmann wrote:
> > On Wednesday 05 May 2010, Takuya Yoshikawa wrote:
> >> There was a suggestion to propose set_le_bit_user() kind of macros.
> >> But what I thought was these have a constraint you two explained and seemed to be
> >> a little bit specific to some area, like KVM.
> >>
> >> So I decided to propose just the offset calculation macro.
> >
> > I'm not sure I understand how this macro is going to be used though.
> > If you are just using this in kernel space, that's fine, please go for
> > it.
> 
> Yes, I'm just using in kernel space: qemu has its own endian related helpers.
> 
> So if you allow us to place this macro in asm-generic/bitops/* it will help us.

No problem at all then. Thanks for the explanation.

Acked-by: Arnd Bergmann <arnd@arndb.de>
