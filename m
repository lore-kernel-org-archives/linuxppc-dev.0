Subject: Re: IDMA: Setting Up Parameter RAM.
To: richard.hendricks@motorola.com (Richard Hendricks)
Date: Fri, 26 May 2000 09:20:56 +1000 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (Linux PPC Mailing List)
In-Reply-To: <392D47A4.DEFFD152@motorola.com> from "Richard Hendricks" at May 25, 2000 10:32:52 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000525232056.7BFDC3C971@elph.research.canon.com.au>
From: gjohnson@research.canon.com.au (Greg Johnson)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have read the MPC860 Users manual section on IDMA, as well as many
other sections. I do indeed call INIT_IDMA after setting things up.
I have even tried calling it several times.

The strange thing is that after a power-on, no matter how many times
I reload the driver and attempt the proceedure, it does not work.
I write to the IDMA parameter RAM and read back to check it and it
looks fine. Upon starting IDMA by asserting DMA Enable, the CPM attempts
to do the IDMA but IDSR asserts OB (out of buffer descriptors). The buffers
have been allocated and set up, I am sure of this.

It is as though the values I am writing into the parameter RAM are
no taking effect, even though I call IDMA_INIT after writing them.
And the bizzar part is that they seem to take affect after a reset,
as though the reset causes them to be written into the CPM??? Like
I said, bizzar.

Greg.

Quoth Richard Hendricks:
>
>
> Have you tried looking at the IDMA section in the MPC823 User's Manual?
> An electronic copy of that portion is at
>
> http://www.mot.com/SPS/ADC/pps/download/823/823RM/16-cpm2.pdf
>
> Also, you could try the IDMA demo under Engineer's Toolbox at
> http://www.mot.com/mpc823
>
> It sounds to me like you're not executing the INIT_IDMA command after
> setting up.

--
+------------------------------------------------------+
| Do you want to know more? www.geocities.com/worfsom/ |
|              ..ooOO Greg Johnson OOoo..              |
| HW/SW Engineer        gjohnson@research.canon.com.au |
| Canon Information Systems Research Australia (CISRA) |
| 1 Thomas Holt Dr., North Ryde, NSW, 2113,  Australia |
|      "I FLEXed my BISON and it went YACC!" - me.     |
+------------------------------------------------------+

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
