From: jonb@marel.is
Subject: Re: Programming Flash
To: Kirk Haderlie <khaderlie@vividimage.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <OFA9C687F1.AC168953-ON00256959.00402DBE@marel.is>
Date: Wed, 13 Sep 2000 11:50:38 +0000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

We use the Macraigor flash programmer to program flash on boards with
soldered down flash,
in our production process.  There does not need to be any boot strap code
programmed by
some other means on the board.

The way it works (I am guessing here), is that the Macraigor flash
programmer loads a program
into the dual ported ram of the MPC823 and starts it.  This program then
gets the data to be
written from the flash programmer and writes it to the flash chip.  This is
how I think it works.
Feel free to correct me if I am wrong :-).

Regards,

Jon Benediktsson
Marel hf.
Reykjavik, Iceland.





                    Kirk Haderlie
                    <khaderlie@vividimage.com>              To:     "'linuxppc-embedded@lists.linuxppc.org'"
                                                            <linuxppc-embedded@lists.linuxppc.org>
                                                            cc:
                    Sent by:                                Subject:     Programming Flash
                    owner-linuxppc-embedded@lists.li
                    nuxppc.org


                    12/09/2000 20:04






We have a FADS 823 board and a MPC823 custom board on the way.  The
question
is: Using the Macrgraigor flash programmer can we program blank flash, or
does some sort of boot strap need to be run in order to configure the on
board memory to use the flash programmer?  How do you program in production
with soldered down flash?  I realize this is a general embedded question.

Kirk Haderlie
kirk@vividimage.com
Vivid Image Engineering


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
