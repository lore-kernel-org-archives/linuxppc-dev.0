Return-Path: <dave.hansen@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419nx829H4zF0l6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 00:57:15 +1000 (AEST)
Subject: Re: [PATCH v13 14/24] selftests/vm: generic cleanup
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-15-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <e50fa00b-724e-ebcb-38b4-22cad9bee1c5@intel.com>
Date: Wed, 20 Jun 2018 07:57:11 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-15-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> cleanup the code to satisfy coding styles.

A lot of this makes the code look worse and more unreadable than before.
 I think someone just ran it through lindent or something.

I also took a few CodingStyle liberties in here because it's _not_ main
kernel code.  I think the occasional 85-column line is probably OK in here.
