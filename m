Message-Id: <200101190841.f0J8fG406174@denx.local.net>
To: xuelong wang <wang_xuelong@yahoo.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Questions about compliing ppcboot-0.6.2 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 19 Jan 2001 00:02:17 PST."
             <20010119080217.1791.qmail@web11802.mail.yahoo.com>
Date: Fri, 19 Jan 2001 09:41:16 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010119080217.1791.qmail@web11802.mail.yahoo.com> you wrote:
>
> I have a target board with a flash on it, and I¡¯d
> like to put ppcboot-0.6.2 into it by a writer. But

I just replied to that. Don't waste your time (and ours!!!) with  old
versions, use a current version of PPCBoot instead.

AND PLEASE SEND PPCBoot RELATED QUESTIONS TO THE PPCBoot MAILING LIST!

AND PLEASE SEND PPCBoot RELATED QUESTIONS TO THE PPCBoot MAILING LIST!

AND PLEASE SEND PPCBoot RELATED QUESTIONS TO THE PPCBoot MAILING LIST!



> when I compile ppcboot-0.6.2 under the environment of

Please get ppcboot-0.7.3 or the latest CVS snapshot.

> 1. A file can not be complied, the error message is:
>
> >/usr/local/src/ppcboot/ppcboot->0.6.2/include/ppc_asm.tmpl:232:
> Error:Rest of line >ignored. First >ignored character
> is ¡®\¡¯.

This is most certainly NOT the error message as you read it. With all
these funny characters it's hard to guess where it complained.

> Can you give me a hint to explain what happened.

Your file got corrupted. Please unpack it from the original  tarball.
Make  sure  to  use  "binary"  mode  when  copying  the file to other
filesystem types.

> but I can not find the definition of ¡°MAKE¡± in this
> file or the other files included by this package. Can
> you tell me what ¡°MAKE ¡± is and where the definition
> locates?

Please see the man page for the make command.

>     3. If you think that I use the wrong versions of
> RedHat Linux, or that I use the wrong CDK , or that

Well, RH-6.2 is a bit old, too, but it works for me; and the HHL  CDK
works here, too.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Time is a drug. Too much of it kills you.
                                      - Terry Pratchett, _Small Gods_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
