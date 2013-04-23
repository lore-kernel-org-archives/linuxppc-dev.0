Return-Path: <dwalker@fifo99.com>
Received: from fifo99.com (fifo99.com [67.223.236.141])
 by ozlabs.org (Postfix) with ESMTP id D25562C011C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 01:02:52 +1000 (EST)
Received: from fifo99.com (unknown [96.24.76.66])
 (Authenticated sender: dwalker)
 by fifo99.com (Postfix) with ESMTPSA id BE9EE343E1CE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 07:55:31 -0700 (PDT)
Date: Tue, 23 Apr 2013 07:55:24 -0700
From: Daniel Walker <dwalker@fifo99.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: arch/powerpc/mm/mmap_64.c on 32bit systems?
Message-ID: <20130423145523.GA28861@fifo99.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,


I was looking at this file, and it looks like it could be used on 32bit
systems. There's patches in the history to add stuff accounting for both
32bits and 64bits .. My assumption was that it's not used because there
are many people who want it on 32bits, and so it hasn't been tested..

Can anyone shed some light on why it's not used for 32bit systems?

Thanks,
Daniel
