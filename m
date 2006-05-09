Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 9999D679F6
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 May 2006 19:50:30 +1000 (EST)
Message-ID: <446063BD.7010805@anagramm.de>
Date: Tue, 09 May 2006 11:41:17 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Mark Chambers <markc@mail.com>
Subject: Re: MPC8540 experience
References: <30268BBA52A6374F8FA87EFDE7CD75410A365644@ebalv004.Bizerba.com>
	<008001c6477e$6a760a50$6401a8c0@CHUCK2>
In-Reply-To: <008001c6477e$6a760a50$6401a8c0@CHUCK2>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: groer@bizerba.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Mark!

Sorry, for my late reply, I wasn't reading the mailing lists for a while
because I am pretty busy with hardware development.

> Hallo Herr Koller,
> ich habe heute ihre EMail 
> (http://ozlabs.org/pipermail/linuxppc-embedded/2004-October/015851.html) 
> gelesen. Hatten sie bereits Erfolg?
> Ich habe ein ähnliches Problem. Wir beutzen bei uns ebenfalls einen PPC und 
> haben das Problem mit Big und Littel-Endian im XServer.

English, please.

You are looking for the SM501 graphics controller working on the PCI Bus
on the MPC8540 as far as I got your mail.

Yes, the last status I got is that the endianess is an issue for the X-server
if the SM501 is on PCI. However there are patches for the framebuffer/X
driver environment which takes care about the RGBA's somewhere out there.
There are also accelerated native X drivers available but I haven't used
those. Additionally, we have the option to swap the colors in hardware,
just in case anything goes wrong. :-)

> Have you seen the work done at Denx (www.denx.de) with the MPC5200 and 
> SM501?

Yes. But AFAIK they have the SM501 on the Local Bus of the MPC5200 which
is a different thing. Check their hardware documentation, if available.

Maybe there are more updates in the meanwhile... Updates are very welcome.
I will have to investigate that further if I come back to the software
layer of my project.


Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
