From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Fwd: mesh SCSI bus locks hard on 7500 when burning a CD-R in
 dao mode
Date: Sat, 27 Jan 2001 12:39:31 +0100
Message-Id: <19341222051115.6472@smtp.wanadoo.fr>
In-Reply-To: <20010126122229.B2874@allspice.cs.swarthmore.edu>
References: <20010126122229.B2874@allspice.cs.swarthmore.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Nope, nothing at all.  :-(  It just freezes.  Since the SCSI bus is
>gone, any attempts to write to logs fail, as do any attempts to read
>them, of course.  cdrdao gets to the "calibrating power" stage, the
>light on the cd-rw drive blinks for a few seconds, and that's it.   Last
>time I tried this experiment, I at least turned swap off first, and the
>system survived a bit longer, but I wasn't able to find anything out.
>Is there any other way to probe what's going on?  I do have a 2 gigabyte
>drive that I could attach to the external SCSI bus and boot from: maybe
>then I could get more info, at least, about what is going on.

Do you get the same lockup without the G3 accelerator ?

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
