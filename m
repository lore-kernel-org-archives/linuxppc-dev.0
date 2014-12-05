Return-Path: <ashutosh.dixit@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id C7B351A0C66
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 05:01:15 +1100 (AEDT)
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: Dan Streetman <ddstreet@ieee.org>
Subject: Re: [PATCH linux-next] Documentation: Build mic/mpssd only for x86_64
References: <25c04eb72c621fc9bdf0aae25782ff5bad5a4b97.1417728278.git.ashutosh.dixit@intel.com>
 <CALZtONBUDyN7OOMV9ziDXMhFN9+bOcsYvJ0an_7T0VV0Hz+8WQ@mail.gmail.com>
Date: Fri, 05 Dec 2014 10:18:57 -0800
In-Reply-To: <CALZtONBUDyN7OOMV9ziDXMhFN9+bOcsYvJ0an_7T0VV0Hz+8WQ@mail.gmail.com>
 (Dan Streetman's message of "Thu, 4 Dec 2014 20:27:06 -0700")
Message-ID: <m3iohq7yem.fsf@adixit-yct.ra.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Foley <pefoley2@pefoley.com>,
 Siva Yerramreddy <yshivakrishna@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "Dutt,
 Sudeep" <sudeep.dutt@intel.com>, "Yokoyama, Caz" <caz.yokoyama@intel.com>,
 Daniel Borkmann <dborkman@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rao,
 Nikhil" <nikhil.rao@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jennings <sjennings@variantweb.net>,
 linux-kernel <linux-kernel@vger.kernel.org>, "Chandramouli,
 Dasaratharaman" <dasaratharaman.chandramouli@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 04 2014 at 07:27:06 PM, Dan Streetman <ddstreet@ieee.org> wrote:
> On Thu, Dec 4, 2014 at 4:27 PM, Ashutosh Dixit <ashutosh.dixit@intel.com> wrote:
>> mic/mpssd along with MIC drivers are currently only usable on
>> x86_64. So build mic/mpssd only for x86_64 to avoid build breaks on
>> big-endian systems.
>
> Only building for x86_64 is fine, but in that case what's the point of
> leaving the htole16() et. al. functions in mpssd.c?  Shouldn't they be
> removed?

I am hoping that once glibc is fixed we can remove this limitation on
building only for x86_64, so I'd rather htole16() et. al. stayed.  As I
said earlier, I'm fine with your patch too, but restricting the build
for x86_64 seems to be the smallest patch which provides an acceptable
solution.
