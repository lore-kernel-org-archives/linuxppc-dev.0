Return-Path: <mmarek@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C4A11A0F88
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jan 2015 03:27:43 +1100 (AEDT)
Message-ID: <54B00175.4050702@suse.cz>
Date: Fri, 09 Jan 2015 17:27:33 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Masahiro Yamada <yamada.m@jp.panasonic.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 0/6] kbuild: refactor Makefiles related with cc-version
References: <1419485488-22336-1-git-send-email-yamada.m@jp.panasonic.com>
In-Reply-To: <1419485488-22336-1-git-send-email-yamada.m@jp.panasonic.com>
Content-Type: text/plain; charset=windows-1252
Cc: Jonathan Corbet <corbet@lwn.net>, Andi Kleen <ak@linux.intel.com>,
 linux-parisc@vger.kernel.org, linux-doc@vger.kernel.org,
 Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Robert Richter <rrichter@cavium.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014-12-25 06:31, Masahiro Yamada wrote:
> Masahiro Yamada (6):
>   kbuild: fix cc-ifversion macro
>   kbuild: do not add $(call ...) to invoke cc-version or cc-fullversion
>   kbuild,gcov: remove unnecessary workaround
>   kbuild,gcov: simplify kernel/gcov/Makefile
>   kbuild: allow cc-ifversion to have the argument for false condition
>   kbuild,gcov: simplify kernel/gcov/Makefile more

Applied to kbuild.git#kbuild, thanks.

Michal
