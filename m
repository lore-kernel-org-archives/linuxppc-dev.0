From: DavidHo@nanometrics.ca
Subject: Re: EXT_DIRECT IDE Mode
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF836561B7.94641389-ON85256E38.0062E7AD-85256E38.0062F7E4@nanometrics.ca>
Date: Thu, 12 Feb 2004 13:00:59 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
