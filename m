In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DADE@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DADE@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0B459F74-AB70-11D8-A4CD-003065F9B7DC@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
From: Dan Malek <dan@embeddededge.com>
Subject: Re: 8260 CPM DP ram free function
Date: Fri, 21 May 2004 17:44:32 -0400
To: "Rune Torgersen" <runet@innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On May 21, 2004, at 1:35 PM, Rune Torgersen wrote:


> I hope someone on this list can push the following patch to one of the
> ppc trees.

Will you please get rid of those #ifdefs?  If the code works, just
use it, if not, don't ask for a patch to be applied.  There is no
reason for this.

> The functions that are added are m8260_cpm_dpfree() and
> m8260_cpm_hostfree()

The "host" functions should simply be removed and drivers should
use kmalloc()/kfree(), manage their own alignment restrictions, since
the 82xx is cache coherent.

Let's clean this up and do it right if we are going to do it at all.

Thanks.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
