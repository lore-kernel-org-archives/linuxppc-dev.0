To: Gerard Flynn <gerard.flynn@lure.u-psud.fr>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Andreas Widder <Andreas.Widder@tqc.de>
Subject: Re: Adding memory to TQM8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 24 Sep 2002 13:46:42 +0200."
             <E17to9K-0003eZ-00@stdev1.machine.clio>
Date: Tue, 24 Sep 2002 14:42:32 +0200
Message-Id: <20020924124237.3A3AFFA8E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Gerard,

in message <E17to9K-0003eZ-00@stdev1.machine.clio> you wrote:
>
>   I'm afraid this question is a bit off-topic because it has perhaps more to

Actually, it is OT here.

> do with hardware than software but I don't know of a better place to ask this
> sort of question.

Well, why don;t you ask TQ directly? They are in the best position to
answer such questions. I've put Mr. Andreas Widder on Cc: - I'm  sure
he can help you.

>   Has anyone had experience adding memory (specifically SDRAM) to a carrier
> board for TQM855 or other TQM mini-modules ?  It seems like this should work
> except for :
>
> 1) The 50 pF capacitance limit on the MPC8xx bus lines (ie. how much is
> already used on the module ?)

Sorry, I'm not a hardware guy.

> 2) As far as I can tell it should be possible to use UPMB to control the new
> memory bank without interfering in any way with the UPMA configuration.  It
> appears that UPMB is only used by ppcboot for the CAN driver (which I'm not
> using).  Is this correct ?

Yes, this is correct.

> 3)  Should it be possible to configure the extra memory bank after ppcboot
> has started, say with an independant program which runs before the kernel ?

While technically possible, this makes little sense to  me.  I  think
you  should  perform this initialization as part of the normal memory
initialization sequence within PPCBoot, so you can  present  one  big
contiguous piece of system RAM to the Linux kernel.

Hope this helps.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Microsoft Compatibility:
     your old Windows 3.11 application crash exactly as the new ones.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
