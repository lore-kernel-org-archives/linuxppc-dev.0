Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Message-ID: <422888BF.8050401@smiths-aerospace.com>
Date: Fri, 4 Mar 2005 11:11:43 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Embedded PPC Linux Mailing List <Linuxppc-embedded@ozlabs.org>
References: <1109951593.32294.5.camel@x.at.lan>
In-Reply-To: <1109951593.32294.5.camel@x.at.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: Re: U-Boot hangs in relocate_code after sw reboot
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jaka Močnik wrote:
> hello!
> 
> I don't really know if this mailing list is the proper place to direct
> questions regarding U-Boot, but I've seen some preceding posts about it,
> so I thought I'd ask...
> 
> I've ported U-Boot over to a custom MPC8560 (PQ3) based board - it works
> well, except that after a sw reboot (from linux kernel or u-boot
> itself), it only gets to the part where it relocates itself to RAM and
> then hangs - the last debug output is 
> 
> Relocating code to 07fd4000...
> 
> and the famous
> 
> Now running in RAM - U-Boot at: 07fd4000 never shows up.
> 
> has anyone experienced similar problems? any hints on what to look at?
> 
> regards,
> 	jaKa

Yes, this is the wrong list, you should use the u-boot list (see 
SourceForge u-boot page).
   http://sourceforge.net/projects/u-boot/

Your question is a FAQ.  Please read the DULG:
   http://www.denx.de/twiki/bin/view/DULG/Manual
especially the FAQ:
   http://www.denx.de/twiki/bin/view/DULG/UBootCrashAfterRelocation

gvb
