Message-ID: <39523796.FF6BFC9F@embeddededge.com>
Date: Thu, 22 Jun 2000 11:58:14 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Patrick Lerda <Lerda@microprocess.com>
CC: Nguyen Xuan Hoang <hoang_nguyen@op.com.sg>,
        linuxppc-embedded@lists.linuxppc.org
Subject: Re: MMU problems?
References: <17B78BDF120BD411B70100500422FC63079F9D@IIS000>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Patrick Lerda wrote:
>
> Have you tried to do complex operation on a 8xx board like compiling the
> kernel.

Yes, and it runs just like any other system that doesn't have any
swap space and a minimal amount of memory.  Some things just don't
work well, and applications fail because few test for memory allocation
failure.

Are there bugs?  Perhaps.  Do I want them fixed?  Yes.

Do you want to help this FREE software effort?  If you are so sure
there is an MMU bug, find it, fix it, and send me the patch.  We would
all be grateful.  If you want dedicated help to assist your custom
product development so you can make money, you may have to pay one
of the very capable embedded Linux companies for this attention.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
