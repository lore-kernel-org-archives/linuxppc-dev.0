Message-ID: <4051A816.5040000@jonmasters.org>
Date: Fri, 12 Mar 2004 12:07:50 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Fillod Stephane <stephane.fillod@thomson.net>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: uncached user space mapping with mmap() ???
References: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFCF@renexch3.rennes.thmulti.com>
In-Reply-To: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFCF@renexch3.rennes.thmulti.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Fillod Stephane wrote:

<snip jcm being anal>

| Indeed! I should have written:
| "The bigger the mmap, the better, and the "lesser"  vma entries
| there will be."

Yes indeed. I shall try not to be such an anal pedant in future.

<snip>

|>Are you somehow assuming you can have variable page sizes or will
|>necessarily be using BATs to map in large regions? If this is the case
|>then do bear in mind the fixed 4K page size on most platforms and the
|>fact that many architectures like 4xx do not have any BATs anyway.

| You're right. To have less entries in the page table, we would need
| variable page sizes, since 4xx does not have BAT. Hence my remark
| in form of question about ability of hugetlb. The answer must
| be in the archive.

I would love to look at the hugetlb stuff but have not got around to it.
FWIW I looked at your Wiki example of uncached access the other day and
will probably send an update for a generic peekpoke utility unless
someone tells me there already is one generally available.

| Thanks for the correction  :-)

Coffee does this kind of thing so I apologise if I ever seem snappy.
Robert Love must hate me by now with the list of stuff for his book!

Jon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
