Message-ID: <07ab01c0da7e$8d645070$4b00000a@foolio1>
From: "Eli Chen" <eli@routefree.com>
To: "Brian Kuschak" <brian.kuschak@skystream.com>,
	"'Gabriel Paubert'" <paubert@iram.es>
Cc: "'Dan Malek'" <dan@mvista.com>,
	<linuxppc-embedded@lists.linuxppc.org>
References: <B25E2E5A003CD311B61E00902778AF2A02044682@SERVER1>
Subject: Re: dcache BUG()
Date: Fri, 11 May 2001 17:57:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


No luck here.  I checked the patched kernel running Brian's test after an
hour and it had frozen up, with one de_put message.

Eli

----- Original Message -----
From: "Brian Kuschak" <brian.kuschak@skystream.com>
To: "'Gabriel Paubert'" <paubert@iram.es>
Cc: "'Dan Malek'" <dan@mvista.com>; "Eli Chen" <eli@routefree.com>;
<linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, May 11, 2001 5:44 PM
Subject: RE: dcache BUG()


> Hi Gabriel,
>
> I tried your patch, but as you expected it didn't fix the problem.  I ran
it
> twice, once with my kernel as I got it from MontaVista, and once with the
> atomic_set() function using regular stw (as it is in the offical sources,
I
> believe).
>
> In both cases I got the de_put messages in a few minutes, and once I got
the
> dentry BUG().
>
> I think Eli might have had better luck, but I'm not sure how long he was
> running the test.
>
> Regards,
> Brian
>
>
>
> > Patch follows, it includes my previous patch. I don't think that it will
> > solve your problem, unless you happen to use a preemptible kernel.
> > While I was at it,  I removed the useless stwcx. in transfer_to_handler.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
