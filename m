Return-Path: <prvs=217711bd88=axboe@fb.com>
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttxtw2rcSzDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 04:02:15 +1100 (AEDT)
Subject: Re: ext4 filesystem corruption with 4.10-rc2 on ppc64le
To: "Theodore Ts'o" <tytso@mit.edu>, Chandan Rajendra
 <chandan@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>, <jack@suse.cz>,
 Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Stephen
 Rothwell" <sfr@canb.auug.org.au>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, <torvalds@linux-foundation.org>
References: <20170104161808.5ad7b4fd@kryten>
 <6085340.JSrffQ0Szo@localhost.localdomain>
 <20170104152837.wdh7cdncs7gyged7@thunk.org>
From: Jens Axboe <axboe@fb.com>
Message-ID: <dc15451c-3c5e-1f61-f108-cea3c08332a9@fb.com>
Date: Wed, 4 Jan 2017 09:23:19 -0700
MIME-Version: 1.0
In-Reply-To: <20170104152837.wdh7cdncs7gyged7@thunk.org>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/04/2017 08:28 AM, Theodore Ts'o wrote:
> On Wed, Jan 04, 2017 at 11:32:42AM +0530, Chandan Rajendra wrote:
>> On Wednesday, January 04, 2017 04:18:08 PM Anton Blanchard wrote:
>>> I'm consistently seeing ext4 filesystem corruption using a mainline
>>> kernel. It doesn't take much to trigger it - download a ppc64le Ubuntu
>>> cloud image, boot it in KVM and run:
>>>
>>> sudo apt-get update
>>> sudo apt-get dist-upgrade
>>> sudo reboot
>>>
>>> And it never makes it back up, dying with rather severe filesystem
>>> corruption.
>>
>> The patch at https://patchwork.kernel.org/patch/9488235/ should fix the
>> bug.
> 
> It looks like this patch is already queued up on the "for-linus"
> branch on the linux-block.git tree.
> 
> Chandra, thanks for pointing this out!  I had missed your e-mail from
> Christmas day, and it was on my todo list to figure out why I was
> seeing lots of 1k block regressions on gce-xfstests post-merge window
> that wasn't showing up on the ext4.git tree before I sent my pull
> request to Linus.
> 
> Jens, could you expedite a pull request to Linus?  This is affecting
> ext4 on 1k block file systems on x86/x86_64, so this is not a ppc-only
> regression.  

Yes, it'll go out this morning.

-- 
Jens Axboe
