Date: Tue, 2 Mar 1999 09:56:55 -0700 (MST)
From: Matt Porter <mmporter@home.com>
To: Cort Dougan <cort@persephone.cs.nmt.edu>
cc: VALETTE Eric <valette@crf.canon.fr>, jpeters@phx.mcd.mot.com,
        paubert@iram.es, jeremy@goop.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Interrupt routing in prep_pci.c
In-Reply-To: <Pine.LNX.3.96.990226001908.16892E-100000@persephone.cs.nmt.edu>
Message-ID: <Pine.LNX.3.96.990302094133.27456D-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 26 Feb 1999, Cort Dougan wrote:

Hey, I don't _like_ just putting the info up there, but it was better than
letting the people who might have had time then to do the code guess how
to identify every single board.  Gathering that information would have
been a pain for anybody on the outside.

Now that I solved my top priority problems (de4x5 failed on 21143-based
Moto boards and booting from flash works finally), I suppose I'll code
this out of necessity.  If anybody's got a working board ID framework or
has any sort of board ID code started for Moto. boards let me know because
I hate to duplicate effort...

> No hand-waving.  Send me code.  I need to check this against other boards
> with different IO areas, different register layouts and such.
> 
> Please remember, your world of the newer moto boards isn't the entire
> scope of what I'm trying to support.  So when you get frustrated with me
> not taking things that are "obvious and easy" fixes please understand that
> it may not work on other machines.
> 
> I'm not adamantly refusing anyones work, I'm trying to get these things to
> evolve into a single working bootloader.
> 
> }First determine Raven or Hawk existence, if it is Raven the following
> }works:
> 

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
