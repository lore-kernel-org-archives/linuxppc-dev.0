From: kd@flaga.is
To: Dan Malek <dmalek@jlc.net>
cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <002566DF.004E489D.00@notes.flaga.is>
Date: Sat, 19 Dec 1998 14:15:03 +0000
Subject: Re: MPX860 : MBX_IMAP_ADDR undefined
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, the file is named linux-2.1.131.tar.bz2 and it was downloaded from
ftp.kernel.org.
So I assume it is the real thing 8-).

Magnus Damm also pointed this out that MBX_IMAP_ADDR should be IMAP_ADDR.

Thank you,

K.D.




Dan Malek <dmalek@jlc.net> on 12/18/98 06:15:02 PM

To:   Kári Davíðsson/Flaga hf/IS
cc:   linuxppc-dev@lists.linuxppc.org
Subject:  Re: MPX860 : MBX_IMAP_ADDR undefined




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
