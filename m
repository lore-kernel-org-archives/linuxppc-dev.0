Mime-Version: 1.0
Message-Id: <p05100301b7fea82467e1@[207.172.166.94]>
In-Reply-To: <20011025100904.D29107@cpe-24-221-152-185.az.sprintbbd.net>
References: <p04330100b7f7f805ef9a@[24.163.33.28]>
 <20011025.233136.74750056.tkoba@ike-dyn.ritsumei.ac.jp>
 <20011025083032.A29107@cpe-24-221-152-185.az.sprintbbd.net>
 <200110251653.f9PGrRd19727@pacific.somerset.sps.mot.com>
 <20011025100904.D29107@cpe-24-221-152-185.az.sprintbbd.net>
Date: Thu, 25 Oct 2001 22:44:08 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Erik van Roode <linuxppc@cthulhu.demon.nl>
Subject: Re: 2.4.13-pre5 crash when mounting proc
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:09 -0700 10/25/01, Tom Rini wrote:
>On Thu, Oct 25, 2001 at 11:53:27AM -0500, Edward Swarthout wrote:
>>  Tom wrote:
>>  >
>>  > Um.  Is that _all_ that changed?  That really shouldn't have any effect
>>  > at all...  What compiler/binutils combo is this?
>>
>>  Well it's important for the COPY_16_BYTES_EXCODE macro to switch back to
>>  the .text section or any following code will go in the __ex_table section!
>
>Well now I feel stupid...  This should be fixed now.

   I updated my copy of the bk:linuxppc_2_4 tree to
2.4.14-pre1 and it boots properly again on my G4.

Erik

--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
