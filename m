From: Ruedi.Hofer@ascom.ch
Date: Mon, 10 Jan 2000 14:59:45 +0100 (CET)
Subject: Antwort: Re: Antwort: Re: Loading the Kernel on a FADS
To: linuxppc-embedded@lists.linuxppc.org
Cc: damm@kieraypc01.p.y.ki.era.ericsson.se
Message-id: <0FO40012JHKFQY@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_qPBN/g5o3AkItHCtIkU/Wg)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



--Boundary_(ID_qPBN/g5o3AkItHCtIkU/Wg)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

It must be a problem of the memory mapping in the ROM.

Static members like hexdigits seem to be excluded from the 
image if PGSZ is set to 0x10000.

The pointer to this array (when called from asc_to_hex) always
points to 0xffffffff.





damm@kieraypc01.p.y.ki.era.ericsson.se on 10.01.2000 13:27:58
An: ruedi.hofer@ascom.ch @ MailGate
Kopie: linuxppc-embedded@lists.linuxppc.org @ MailGate 
Thema: Re: Antwort: Re: Loading the Kernel on a FADS

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



--Boundary_(ID_qPBN/g5o3AkItHCtIkU/Wg)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
