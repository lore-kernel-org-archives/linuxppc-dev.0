Message-Id: <200110122022.f9CKM7Y15760@aslan.scsiguy.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: no luck with Adaptec SCSI controller in 2.4.X 
In-Reply-To: Your message of "Fri, 12 Oct 2001 15:52:07 EDT."
             <20011012194947.SUPU19094.tomts9-srv.bellnexxia.net@there>
Date: Fri, 12 Oct 2001 14:22:07 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I can already tell you what is happening.  We send a bunch of commands
>> to the drive expecting it to respond with QUEUE FULL status should we
>> send too many, but the drive instead accepts them for future completion
>> but never actually responds to the commands.  This is why we time out.
>
>So there is really nothing anyone can do about it?  I will just need to
>keep the tag depth at 8 for that drive.

The driver could lower the tag depth when timeouts occur, but Linux
doesn't really tell you when a timeout happens.  The driver is only
told that it should abort a particular transaction which could be for
lots of different reasons.

>Earlier you said something about a firmware upgrade for those drives?
>Would a firmware upgrade help solve this issue more cleanly or given that
>it is now working should I just forget about it and leave well enough
>alone.

Since this is a firmware type issue, if you can find better firmware
it could fix the problem.  Based on the age of the drive, however, it
might be pretty hard to get newer firmware.

--
Justin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
