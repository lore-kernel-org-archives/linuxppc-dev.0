Message-Id: <200103190002.TAA57145@p2.parker.boston.ma.us>
To: Ralph Blach <rblach@intrex.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: es1371.o sound module on a IBM405 gp walnut 
In-reply-to: Your message of "Sun, 18 Mar 2001 11:32:32 EST."
             <3AB4E320.233162CD@intrex.net>
Date: Sun, 18 Mar 2001 19:02:27 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ralph Blach wrote:
>
>I am trying to get an es1371. sound module working on an IBM405 walunt
>developement kit.  8 bit sound works ok
>but 16 bit sound sounds like noise.  Will this driver have to be made
>Endian  aware?

I tried it with madplay and found that it seemed to almost work; the
sound was slightly rough but 'working'.  It sounded just slightly
distorted but I was not sure if that was due to the version of madplay
I was using or the es1371 driver.  It certainly wasn't noise...

I'm not sure what madplay was putting out - it may have been 8 bit
stereo (but I thought it would go for 16 bit stereo).

This was running the linuxppc_2_5 branch, however, and only after I
made some minor pci fixes.

what are you sending out and how? (i.e. cat xxx >/dev/ds

-brad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
