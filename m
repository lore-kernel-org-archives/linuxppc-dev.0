From: DavidHo@nanometrics.ca
In-Reply-To: <402B9456.7000007@imc-berlin.de>
Subject: Re: EXT_DIRECT IDE Mode
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFFDBDCE26.B71E8E02-ON85256E39.00595A10-85256E39.005A13FA@nanometrics.ca>
Date: Fri, 13 Feb 2004 11:23:53 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve,

We have decided to move to a newer kernel (2.4.20 or greater).
As a simple check, would you please give me a list of files with the
CONFIG_IDE_EXT_DIRECT #ifdef so I can get a bit of assurance that I have
the support in the kernel before making the move.

Thanks,
David



David,

> The EXT_DIRECT item is already there in the configuration menu.  I
thought
> it has been fully implemented in that version, until I saw the functions
> are not being called in platform_init.
>
> Base on your knowledge, which kernel version has this mode (MPC8xx IDE)
> fully working?
Hmm. I'd say it started somewhen at 2.4.20.

> And do you know the work involved in porting the support to 2.4.18?  I am
> gauging which is the easier route moving all the changes I have already
> made to 2.4.2x or porting the changes to 2.4.18.

I don't know how much changes you did. But I strongly recommend moving
to something newer! Otherwise you only get this advice later if you
run into some other problem and try to get help on the mailing list!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
