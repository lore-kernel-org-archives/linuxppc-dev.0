Return-Path: <corbet@lwn.net>
Received: from vena.lwn.net (tex.lwn.net [70.33.254.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D65221A0C32
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 03:36:08 +1100 (AEDT)
Date: Fri, 5 Dec 2014 11:18:18 -0500
From: Jonathan Corbet <corbet@lwn.net>
To: Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: Re: [PATCH linux-next] Documentation: Build mic/mpssd only for x86_64
Message-ID: <20141205111818.551a870f@lwn.net>
In-Reply-To: <25c04eb72c621fc9bdf0aae25782ff5bad5a4b97.1417728278.git.ashutosh.dixit@intel.com>
References: <25c04eb72c621fc9bdf0aae25782ff5bad5a4b97.1417728278.git.ashutosh.dixit@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Peter Foley <pefoley2@pefoley.com>,
 Siva Yerramreddy <yshivakrishna@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
 Sudeep Dutt <sudeep.dutt@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>,
 Daniel Borkmann <dborkman@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nikhil Rao <nikhil.rao@intel.com>, linuxppc-dev@lists.ozlabs.org,
 Jennings <sjennings@variantweb.net>, Dan Streetman <ddstreet@ieee.org>,
 Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu,  4 Dec 2014 13:27:29 -0800
Ashutosh Dixit <ashutosh.dixit@intel.com> wrote:

> mic/mpssd along with MIC drivers are currently only usable on
> x86_64. So build mic/mpssd only for x86_64 to avoid build breaks on
> big-endian systems.

I can certainly apply this.  But it seems to me that this kind of code
doesn't belong in the documentation directory.  How about a patch to move
it to tools/ ?

jon
