Return-Path: <msuchanek@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40h1DX74FszF2N1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 01:56:12 +1000 (AEST)
Date: Wed, 9 May 2018 17:56:09 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>, fweimer@redhat.com, msuchanek@suse.com,
 Thomas Gleixner <tglx@linutronix.de>, mhocko@kernel.org,
 Ulrich.Weigand@de.ibm.com, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com, Andrew Morton
 <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@kernel.org>
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
Message-ID: <20180509175609.0adb6e57@kitsune.suse.cz>
In-Reply-To: <5e7ed7d9-3fbc-7d60-9c69-bdcef6025167@intel.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <20180509174335.0faab9fc@kitsune.suse.cz>
 <5e7ed7d9-3fbc-7d60-9c69-bdcef6025167@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 May 2018 08:46:08 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 05/09/2018 08:43 AM, Michal Such=C3=A1nek wrote:
> > It seems it is somehow assumed this is key 0 but I did not find it
> > documented anywhere nor did I notice an interface for determining
> > the default key. =20
>=20
> Does the manpage not count as documentation?  :)
>=20
> "pkey 0 is used as the default key"
>=20
> https://manpages.debian.org/stretch/manpages/pkeys.7.en.html

I happened to be reading Documentation/x86/protection-keys.txt which is
much more terse. The man page is certainly clearer.

Thanks

Michal
