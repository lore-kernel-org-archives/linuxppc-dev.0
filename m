To: "AUBERT Cedric" <cedric_aubert@softhome.net>
Cc: "LinuxPPC Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: U-Boot question 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 11 Feb 2003 09:03:34 +0100."
             <NEEAIENMOLHNBKKFKIDMMEEICAAA.cedric_aubert@softhome.net>
Date: Tue, 11 Feb 2003 18:36:42 +0100
Message-Id: <20030211173647.641B8C5E20@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <NEEAIENMOLHNBKKFKIDMMEEICAAA.cedric_aubert@softhome.net> you wrote:
>
> I am in the state "while(learning){ .... }" of the U-Boot Porting Guide in
> the README file.
...
> The option CFG_SDRAM_BASE is the physical start address of SDRAM.
> Okay, I understand that. But it's written _Must_ be 0 here.

Right. Linux on PowerPC expects RAM to start at 0.

> How can I do if my SDRAM ( on a MPC860 Board ) start at 04000000 ???

Just define a memory map where your SDRAM starts  at  0.  The  memory
controller is programmed in software, so you can chose any memory map
you like.

> PS : Sorry to don't post to the U-Boot mailing list but I have a failure
> notice each time
> I try to post on it. (550-Envelope sender verification failed)

Then fix this!


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The use of Microsoft crippleware systems is a sin that  carries  with
it its own punishment.
         -- Tom Christiansen in <6bo3fr$pj8$5@csnews.cs.colorado.edu>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
