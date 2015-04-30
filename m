Return-Path: <msnitzer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23FDD1A0033
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2015 01:18:22 +1000 (AEST)
Date: Thu, 30 Apr 2015 11:18:18 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: ppc64le crash in dm on 4.1+
Message-ID: <20150430151818.GA30542@redhat.com>
References: <CACPK8XeQjdmwFScvEDMo4ie7=-e6WfW0cvW=NMLqC+zpOOJeTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACPK8XeQjdmwFScvEDMo4ie7=-e6WfW0cvW=NMLqC+zpOOJeTg@mail.gmail.com>
Cc: dm-devel@redhat.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 29 2015 at 11:29pm -0400,
Joel Stanley <joel@jms.id.au> wrote:

> Hello,
> 
> I just booted 3d99e3fe13d473ac4578c37f477a59b829530764 (linus' tree as
> of this morning) on a Tuletta and got the following:

This is fixed with the following commit (which I just sent to Linus for
4.1-rc2 inclusion):
https://git.kernel.org/cgit/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=for-next&id=aa6df8dd28c01d9a3d2cfcfe9dd0a4a334d1cd81
