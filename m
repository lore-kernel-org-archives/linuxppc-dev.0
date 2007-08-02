Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id D8C2CDDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Aug 2007 04:29:41 +1000 (EST)
Message-ID: <46B22291.5000608@anagramm.de>
Date: Thu, 02 Aug 2007 20:29:37 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Ansari <ma.harounansari@gdatech.co.in>
Subject: Re: Reboot Command Makes kernel to hang (MPC8560)
References: <000801c7cf51$f98ebb90$9503a8c0@Ansari>	<880B302A-742A-4CC1-BB41-E7BD1CE570C6@kernel.crashing.org><007001c7d341$d3ae29d0$9503a8c0@Ansari><46AF2085.1060603@anagramm.de>	<00C9C80A-3276-4BC1-9ADA-48CE2002BADA@kernel.crashing.org>
	<000b01c7d4d1$1ac37920$9503a8c0@Ansari>
In-Reply-To: <000b01c7d4d1$1ac37920$9503a8c0@Ansari>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Ansari!

Ansari schrieb:
> Hi Koller & Kumar
> 
> Thanks for ur reply.
> 
> Is there a way to reset the full chip (MPC8560)  whenever core reset 
> occurs (using hardware or software) ??

I recommend you to have a look at i.e. the MPC8540ADS reference design
(as an example, the 8560 should be similar) to see how the reset signals
are realized. I didn't run into problems with the reset circuitry.
u-boot resets my thing by issung a "reset" and linux does the same when
I do a "shutdown -r now" or similar thing.
Read the code at these places what's happening there.
AFAICT this is not done by enabling the Watchdog and wait
until it triggers. (Hence, that would be interesting to try...)

In your case I would have a look at the ramdisk code to see where it/what
fails in the first place.

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
