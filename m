Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <022401c0fd82$84f098f0$3877b5d3@dolbae>
From: "SangTae Ha" <stha@postech.edu>
To: "Wolfgang Denk" <wd@denx.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20010625084847.744FD10072@denx.denx.de>
Subject: Re: RPXclassic PPCBOOT on RAM 
Date: Mon, 25 Jun 2001 23:24:12 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I agree with you that this topic may not be directly related with this board. I will use appropriate mailing lists instead. Thank you very much for your valuable feedback. However, I had to say that your comment is hardly useful since I already tried possible basic things, you mentioned, such as  flash type and width. I've used BDI debugger before doing linux work since my early projects. It was very successful for my several projects. I've got the detailed information about the informations  from ABATRON's Reudi but my configuration for board is same with him. I wantd to reduce my time for checking others before Reudi answers for my question. Anyway, I will test the hardware first and finally find what's wrong with it.

Thanks.

----- Original Message -----
From: "Wolfgang Denk" <wd@denx.de>
To: "SangTae Ha" <stha@postech.edu>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Monday, June 25, 2001 5:48 PM
Subject: Re: RPXclassic PPCBOOT on RAM


> In message <010601c0fd39$ef0cca90$3877b5d3@dolbae> you wrote:
> >
> > I am trying to have the PPCBOOT work on RPXclassic board. I've
>
> I don't see any Linux content in this message, so it's off  topic  in
> this mailing list.
>
> Chances to receive help for PPCBoot porting issues are much better in
> the PPCBoot User's mailing list.

OK.

>
> > already port the 8xxROM this board already but I've failed with
> > PPCBOOT. All configuration parameters are same with 8xxROM and my
> > BDI2000 didn't get the flash information of RPXClassic (FLASH TYPE,
> > CHIPSIZE, BUSWIDTH), therefore I really want to test the PPCBOOT on
>
> When you don't have such basic hardware information you better forget
> about low-level work like porting PPCBoot.

I just wanted to know other debugging techinques to save my time.

>
> > RAM space first to debug. In order to make srec file run on RAM
>
> This is not a good idea.

OK

>
> Executing code from the boot device (flash memory)  is  the  simplest
> thing  you  can  do.  Running  from (SD)RAM is MUCH more complicated,
> since it needs a LOT of  initialization  which  must  be  correct  or
> you'll just see random problems.
>
> It is NOT a good idea to try complicated things as long as you  don't
> have the muchg simpler things running first.

OK

>
> > there woule be many efficient debugging techniques. I am currently
> > using BDI2000, as I mentioned above, but I couldn't get the flash
> > work. How can I debug the PPCBOOT efficiently in my current stage?
>
> Why not? You know the flash type. There are two ways to attach it  to
> the  bus  (as  8  or as 16 bit devices), and there are 4 possibel bus
> widths (8, 16, or 32 bit). Even without any further information it is
> just a couple of minutes to try out these 8 possible combinations.

I've tried all possible configurations already. I've got this problem for the first time in my project.
BDI2000 could be one of the suspicious problems, I guess. I will check.

>
> When you cannot get flash working, I guarantee  you  will  fail  with
> SDRAM, too.
>
> > Any comments would be appreciated.
>
> Try simple things first.

OK

>
> And better post such questions to the ppcboot mailing list.
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> panic: kernel trap (ignored)
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
