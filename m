Return-Path: <arndbergmann@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRw0D74SXzDqb7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 21:17:32 +1000 (AEST)
Received: by mail-oi0-x242.google.com with SMTP id h4so2822519oib.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:17:32 -0700 (PDT)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <1494932559.3971.18.camel@abdul.in.ibm.com>
References: <1494932559.3971.18.camel@abdul.in.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 May 2017 13:17:29 +0200
Message-ID: <CAK8P3a1e+Rgv2emmTgewm-YJ6j2H7xJzM_+Mz8J3OKWCpbsD6g@mail.gmail.com>
Subject: Re: Mainline build brakes on powerpc with error :
 fs/xfs/xfs_iomap.c:1152: undefined reference to `.put_dax
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "Darrick J. Wong" <darrick.wong@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 16, 2017 at 1:02 PM, Abdul Haleem
<abdhalee@linux.vnet.ibm.com> wrote:
> Hi,
>
> Today's mainline 4.12-rc1 fails to build for the attached configuration
> file on Power7 box with below errors.
>
> $ make
> fs/built-in.o: In function `xfs_file_iomap_end':
> fs/xfs/xfs_iomap.c:1152: undefined reference to `.put_dax'
> fs/built-in.o: In function `xfs_file_iomap_begin':
> fs/xfs/xfs_iomap.c:1071: undefined reference to `.dax_get_by_host'
>
> Also reproducible on latest linux-next, and the last successful build
> was at next-20170510.

This should be fixed by https://patchwork.kernel.org/patch/9725515/

  Arnd
