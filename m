Message-ID: <XFMail.001009181549.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <19340903045945.2380@192.168.1.2>
Date: Mon, 09 Oct 2000 18:15:49 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: can't boot 2.4.0-t9
Cc: linuxppc-dev@lists.linuxppc.org,
        Giuliano Pochini <pochini@denise.shiny.it>,
        Topi Kanerva <tkanerva@ees2.oulu.fi>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>is this the plain 2.4.0-test9 or linuxcare devel version?
>>If I were you, I'd try to backport the test7 scsi code to make
>>the hack work again.
>>I don't know about the drivers/scsi stuff, because I have a pismo
>>(and hence no scsi), but for sure none of the 2.4.0-testx kernels
>>have worked for me in terms of X: if I start X (4.0.1c), the
>>lcd screen goes black, or then just completely wild.
>>
>>Can anyone else with a pismo confirm this?
>
> For the SCSI resources problem, I have to check is the main tree is up-
> to-date with the latest PPC fixes. You may want to try with the PPC
> bitkeeper tree.

Can I download only the arch/ppc tree ?

> For the X 4 vs. 2.4 issue, I've been biten by this for a long time (on a
> Pismo too and on a G4) until I figured out that the X server dies when
> looking up font path.

4.0.0 works fine here (test7).


Bye.
    Giuliano Pochini ->)|(<- Shiny Corporation {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
