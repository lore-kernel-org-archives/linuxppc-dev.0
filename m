Message-ID: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6CFCF@renexch3.rennes.thmulti.com>
From: Fillod Stephane <stephane.fillod@thomson.net>
To: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: uncached user space mapping with mmap() ???
Date: Tue, 9 Mar 2004 13:49:00 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jon Masters wrote:
>> The bigger the mmap, the better, and the "lesser" entries in page table
>> there will be.
>
>That's not true though. I went along with the rest of your mail, but the
>above just does not make sense to me.

Indeed! I should have written:
"The bigger the mmap, the better, and the "lesser"  vma entries
there will be."

The idea is:  mmap(N*pagesize()) is better than   N times mmap(pagesize()),
provided you do need to address all this space.

>Are you somehow assuming you can have variable page sizes or will
>necessarily be using BATs to map in large regions? If this is the case
>then do bear in mind the fixed 4K page size on most platforms and the
>fact that many architectures like 4xx do not have any BATs anyway.

You're right. To have less entries in the page table, we would need
variable page sizes, since 4xx does not have BAT. Hence my remark
in form of question about ability of hugetlb. The answer must
be in the archive.

Thanks for the correction  :-)

Regards,
Stephane

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
