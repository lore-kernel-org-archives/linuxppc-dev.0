Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 8FD77DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 11:06:08 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so342842yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 17:06:06 -0700 (PDT)
Date: Mon, 20 Oct 2008 20:04:20 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Please pull 'next' branch of 4xx tree
Message-ID: <20081021000420.GA12065@yoda.jdub.homelinux.org>
References: <20081020131402.GA2300@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081020131402.GA2300@yoda.jdub.homelinux.org>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 20, 2008 at 09:14:02AM -0400, Josh Boyer wrote:
>Hi Ben,
>
>Please pull the 'next' branch of the 4xx tree to pick up what should be
>most of the remaining changes for 2.6.28.  Defconfig updates will come
>after -rc1.
>
>josh
>
>The following changes since commit 6dc6472581f693b5fc95aebedf67b4960fb85cf0:
>  Benjamin Herrenschmidt (1):
>        Merge commit 'origin'
>
>are available in the git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

As we discussed, I added one more commit on top of this.  It's for the
EMAC build break and is the patch that Stephen has been carrying in
linux-next for the past few days.

josh
