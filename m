Message-ID: <67505026E29DD311A9AA00508B7315F350A606@EXCHANGE>
From: Julia Elbert <jelbert@enerdyne.com>
To: "'Phillip Soltan'" <psoltan@pacificsw.com>,
        "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: scc2 using brg4 in uart.c
Date: Wed, 13 Dec 2000 10:59:22 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Phillip,
Thank you for responding. One of these days I will hopefully need less help.

Did you enable the transceiver hardware through the appropriate BSCR
register?
yep, we are o.k. here
 Did you configure the SCC2 priority in the CICR register?
yes, CICR_SCB_SCC2 is enabled in commproc.c

I am using the 860T
Originally, we wrote a hdlc synchronous driver on SCC2 using BRG4 that was
loaded and worked with this port, if that helps.

Hmm. darn I just found that my sicr is wrong, it should be. Dan had it right
and I killed it with a 26. uuuggh, I should know better.
 cp ->cp_sicr |= 0x0000 1b 00;

scc2 has interrupts! Amazing, how that works. Now, maybe I can find my data
somewhere....
Thank you.
 --Julia


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
