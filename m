To: Sylvain Munaut <tnt@246tnt.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on a Motorola MPC5200 ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 Jan 2004 18:28:38 +0100."
             <40169FC6.1040805@246tNt.com>
Date: Tue, 27 Jan 2004 20:14:37 +0100
Message-Id: <20040127191442.3B541C108D@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40169FC6.1040805@246tNt.com> you wrote:
>
> I'd like to run linux on a future custom board based on a motorola
> MPC5200 and I have a few questions :
>
>  - What is the current support for it ? Stable ... I'd need the DMA (

Yes, it is stable, with a couple of well-known problems.

> well, their 'special DMA fancy stuff' ;) ), ATA, DDR, I2S, AC97 mainly.

ATA: OK as long as you don't enable DMA writes (*)

DDR: OK (use icecube_5200_DDR configuration in U-Boot); the LOWBOOT
     option is not working yet (we are working on this)

I2S: simultaneous reading and writing is impossible (*)
AC97: ditto

(*) to fix these issues we're waiting for a  bugfix  release  of  the
    BestComm CAPI which might become availabe by mid February.

>  - I'd really like to run a 2.6 kernel on it. If it's not yet ported to

Forget it. Why would you want to  do  that?  Which  features  do  you
expect from 2.6 which are not available in 2.4?

> the 2.6 what is the current ppc support for 2.6 ? Would I "only" need to
> port MPC specifics ?

No comment.

>  - Where can I find the current stuff ? I've taken what is in
> ppc.bkbits.net/linux-2.4-mpc5xxx, is there other things I should consider ?

Our current stuff is on our CVS  server,  in  the  linuxppc_2_4_devel
tree.  As  far  as the 5200 is concerned this includes stuff that was
submitted but not yet added to the linux-2.4-mpc5xxx  tree  (but  Tom
promised to add our patches).


Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Machines take me by surprise with great frequency.      - Alan Turing

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
