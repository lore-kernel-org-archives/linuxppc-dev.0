Message-ID: <3E650AAF.7060804@embeddededge.com>
Date: Tue, 04 Mar 2003 15:21:03 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Dale Farnsworth <dale@farnsworth.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patch boot/common/relocate.S to start kernel at 0x000c
References: <20030304191644.GA4524@rover.farnsworth.org> <3E64FD53.3030107@embeddededge.com> <20030304201302.GA4683@rover.farnsworth.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dale Farnsworth wrote:

> No, I wasn't sure.  Now after some more looking, I'm sure that
> it *won't* work for 40x, 44x, and 8xx.
>
> I'll find another way.

Well, one option that may be the easiest is to just change all
of the linux head.S files to have the three nops again.  When we
split these file apart a while back, we just removed everything that
wasn't necessary.  Just put a note in those files why they are
present.  They don't cost anything since these are exception vector
locations or temporary storage locations for special purposes.

Thanks.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
