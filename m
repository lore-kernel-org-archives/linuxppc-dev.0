Return-Path: <roland@redhat.com>
Received: from QMTA10.emeryville.ca.mail.comcast.net
	(qmta10.emeryville.ca.mail.comcast.net [76.96.30.17])
	by ozlabs.org (Postfix) with ESMTP id 55BF1DDE16
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 12:20:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
In-Reply-To: Nathan Lynch's message of  Thursday,
	3 July 2008 18:41:40 -0500 <20080703234140.GC9594@localdomain>
References: <20080703234140.GC9594@localdomain>
Message-Id: <20080704021929.5E9EF1541F5@magilla.localdomain>
Date: Thu,  3 Jul 2008 19:19:29 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Why not just use ELF_HWCAP for this?  It looks like powerpc only has 3 bits
left there (keeping it to 32), but 3 is not 0.  If not that, why not use
dsocaps?  That is, some magic in the vDSO, which glibc already supports on
all machines where it uses the vDSO.  (For how it works, see the use in
arch/x86/vdso/vdso32/note.S for CONFIG_XEN.)


Thanks,
Roland
