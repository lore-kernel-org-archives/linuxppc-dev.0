Message-ID: <003801be435b$600ad480$1b415c9b@s307-17.msoe.edu>
From: "ian reinhart geiser" <geiseri@msoe.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
Date: Mon, 18 Jan 1999 21:25:34 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



-----Original Message-----
From: Brad Midgley <brad@pht.com>
To: Daniel Jacobowitz <drow@false.org>
Cc: Paul.Mackerras@cs.anu.edu.au <Paul.Mackerras@cs.anu.edu.au>;
linuxppc-dev@lists.linuxppc.org <linuxppc-dev@lists.linuxppc.org>
Date: Monday, January 18, 1999 5:40 PM
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)


    ---SNIP---
>Now lets discussw why a buffer underrun may occur:
>
>1) Disabled disconnect/reconnect on the SCSI bus
>
    okay...
    how do we deal with this?
    i can burn under MacOS but as i played with it more
    and more i found that under Linux that the SCSI bus
    was timeing out.

    i am running 2.1.35 with the memory patched....

    is there a patch rev that fixes the disconnect/reconnect?

    thanks for the help, i can feel that we are getting closer.
    at least people have confirmed what i have found.

    -ian reinhart geiser


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
