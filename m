Return-Path: <dave.hansen@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41VSdj2XNbzF3HZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2018 03:56:40 +1000 (AEST)
Subject: Re: [PATCH v13 19/24] selftests/vm: associate key on a mapped page
 and detect access violation
To: Ram Pai <linuxram@us.ibm.com>
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-20-git-send-email-linuxram@us.ibm.com>
 <048b1de9-85f8-22ff-a31a-b06a382769bb@intel.com>
 <20180717161332.GH5790@ram.oc3035372033.ibm.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <febe6668-c66a-4601-63da-44501faf12ee@intel.com>
Date: Tue, 17 Jul 2018 10:56:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180717161332.GH5790@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2018 09:13 AM, Ram Pai wrote:
> I have incorporated almost all of your comments. But there are some
> comments that take some effort to implement. Shall we get the patches
> merged in the current form?  This code has been sitting out for a while.
> 
> In the current form its tested and works on powerpc and on x86, and
> incorporates about 95% of your suggestions. The rest I will take care
> as we go.

What constitutes the remaining 5%?
