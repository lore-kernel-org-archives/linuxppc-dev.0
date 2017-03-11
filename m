Return-Path: <axboe@kernel.dk>
Received: from mail-pg0-x231.google.com (mail-pg0-x231.google.com
 [IPv6:2607:f8b0:400e:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vgfPs2bHGzDqMd
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Mar 2017 09:46:41 +1100 (AEDT)
Received: by mail-pg0-x231.google.com with SMTP id b129so50945317pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Mar 2017 14:46:41 -0800 (PST)
Subject: Re: 4.11.0-rc1 boot resulted in WARNING: CPU: 14 PID: 1722 at
 fs/sysfs/dir.c:31 .sysfs_warn_dup+0x78/0xb0
To: Brian Foster <bfoster@redhat.com>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>
References: <1488904264.3961.17.camel@abdul-ThinkPad-T450>
 <20170308131705.GB23404@bfoster.bfoster>
 <1489056606.3961.41.camel@abdul-ThinkPad-T450>
 <20170309125919.GA16713@bfoster.bfoster>
Cc: linux-xfs@vger.kernel.org, mpe@ellerman.id,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <158127ce-d71d-56a5-3dd3-f676b106c65d@kernel.dk>
Date: Sat, 11 Mar 2017 15:46:36 -0700
MIME-Version: 1.0
In-Reply-To: <20170309125919.GA16713@bfoster.bfoster>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/2017 05:59 AM, Brian Foster wrote:
> cc linux-block
> 
> On Thu, Mar 09, 2017 at 04:20:06PM +0530, Abdul Haleem wrote:
>> On Wed, 2017-03-08 at 08:17 -0500, Brian Foster wrote:
>>> On Tue, Mar 07, 2017 at 10:01:04PM +0530, Abdul Haleem wrote:
>>>>
>>>> Hi,
>>>>
>>>> Today's mainline (4.11.0-rc1) booted with warnings on Power7 LPAR.
>>>>
>>>> Issue is not reproducible all the time.

Is that still the case with -git as of yesterday? Check that you
have this merge:

34bbce9e344b47e8871273409632f525973afad4

in your tree.

-- 
Jens Axboe
