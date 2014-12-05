Return-Path: <ashutosh.dixit@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id F2AF81A0060
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 05:11:42 +1100 (AEDT)
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH linux-next] Documentation: Build mic/mpssd only for x86_64
References: <25c04eb72c621fc9bdf0aae25782ff5bad5a4b97.1417728278.git.ashutosh.dixit@intel.com>
 <20141205111818.551a870f@lwn.net>
Date: Fri, 05 Dec 2014 10:29:35 -0800
In-Reply-To: <20141205111818.551a870f@lwn.net> (Jonathan Corbet's message of
 "Fri, 5 Dec 2014 09:18:18 -0700")
Message-ID: <m3a9327xww.fsf@adixit-yct.ra.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Peter Foley <pefoley2@pefoley.com>, Siva Yerramreddy <yshivakrishna@gmail.com>,
 Jiri Kosina <jkosina@suse.cz>, Randy Dunlap <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Dutt,
 Sudeep" <sudeep.dutt@intel.com>, "Yokoyama, Caz" <caz.yokoyama@intel.com>,
 Daniel Borkmann <dborkman@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rao,
 Nikhil" <nikhil.rao@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jennings <sjennings@variantweb.net>, Dan Streetman <ddstreet@ieee.org>,
 "Chandramouli, Dasaratharaman" <dasaratharaman.chandramouli@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 05 2014 at 08:18:18 AM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Thu,  4 Dec 2014 13:27:29 -0800
> Ashutosh Dixit <ashutosh.dixit@intel.com> wrote:
>
>> mic/mpssd along with MIC drivers are currently only usable on
>> x86_64. So build mic/mpssd only for x86_64 to avoid build breaks on
>> big-endian systems.
>
> I can certainly apply this.  But it seems to me that this kind of code
> doesn't belong in the documentation directory.  How about a patch to move
> it to tools/ ?

Yes, let's resolve the situation for now and then we'll submit another
patch soon to move it to tools.
