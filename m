Message-Id: <5.1.0.14.2.20030626124723.02159eb0@falcon.si.com>
Date: Thu, 26 Jun 2003 12:51:49 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: flash AMD
In-Reply-To: <00053337.C22236@netcourrier.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 05:10 PM 6/26/2003 -0400, greggiraud@netcourrier.com wrote:

>Hi, I try to use my flash on my custom card. It's like a MPC8260ADS.
>The flash is the AMD AM29DL323GB. I read some source from ppcboot with
>am29dl323b. And for the moment I just want to ask the flash the
>manufacturor id.
>I try the source that I have  found, but it doesnt function. When I make the
>autodelect sequence, and then read the first word, normally I would read the
>manufacturor ID, but I read the word that is the flash.
>
>So is someone has used this flash? Have you got source or ideas about that?
>
>Nota: I initialisaze the flash when ppcboot is relocated in the ram.
>grego
>greggiraud@netcourrier.com


The flash control sequences are merely memory reads and write.  I usually
use a debugger to do the flash write sequences by hand (per the
manufacturer's data sheet) to put the flash in "read ID" mode and then read
it out, again via the debugger.  This gives me the best way to try all the
potential combinations (bus width, chip width, etc.) and figure out what
the proper memory operations are to make it work.  Even when I think I know
what the configuration is, I usually do the hand operations to verify that
it really works (and have been surprised more than once :-).

Note that you can very easily test your understanding of the erase and
write algorithms this way too.

gvb


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
