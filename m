From: greggiraud@netcourrier.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: flash AMD
Date: Thu, 26 Jun 2003 17:10:52 CEST
Mime-Version: 1.0
Message-Id: <mnet1.1056640252.5141.greggiraud@netcourrier.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, I try to use my flash on my custom card. It's like a MPC8260ADS.
The flash is the AMD AM29DL323GB. I read some source from ppcboot with am29dl323b. And for the moment I just want to ask the flash the manufacturor id. I try the source that I have  found, but it doesnt function. When I make the autodelect sequence, and then read the first word, normally I would read the manufacturor ID, but I read the word that is the flash.

So is someone has used this flash? Have you got source or ideas about that?

Nota: I initialisaze the flash when ppcboot is relocated in the ram.
grego
greggiraud@netcourrier.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
