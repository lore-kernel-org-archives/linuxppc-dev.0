Message-ID: <367A9BA6.1FDD4CE7@jlc.net>
Date: Fri, 18 Dec 1998 13:15:02 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: kd@flaga.is
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: MPX860 : MBX_IMAP_ADDR undefined
References: <002566DC.006770DB.00@notes.flaga.is>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


kd@flaga.is wrote:

> ...... Unfortunately this fails on arch/ppc/kernel/irq.c
> because of  MBX_IMAP_ADDR undefined

Really?  It should simply be IMAP_ADDR now.  The sources
I downloaded a few days ago were correct.  Are you sure
you downloaded the right stuff from the right place?


    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
