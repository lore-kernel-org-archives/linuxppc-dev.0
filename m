Message-ID: <3879D04D.D0FB5CFE@switchboard.ericsson.se>
Date: Mon, 10 Jan 2000 13:27:58 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: Ruedi Hofer <ruedi.hofer@ascom.ch>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Antwort: Re: Loading the Kernel on a FADS
References: <38798A2F.457B1077@ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Not that I understand the above problem any better, but I see where it
> crashes more clearly now.
> 
> > It always crashes when it jumps into a string function from the
> > lib 'string'. (e.g. strchr)
>
> Any ideas??

I think someone messed with PGSZ settings in main.c...
I changed it back to 4096 and things started to work again.

I don't really know why.

It would be good if someone sat down and had a thought 
about what is going on... 
 
Hope it helps /

Magnus Damm

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
