Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1109951593.32294.5.camel@x.at.lan>
References: <1109951593.32294.5.camel@x.at.lan>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <22ff4416fc868b02d37f46a31869e3f9@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 4 Mar 2005 10:18:18 -0600
To: =?UTF-8?Q?Jaka_Mo=C4=8Dnik?= <jaka@activetools.si>
Cc: Embedded PPC Linux Mailing List <Linuxppc-embedded@ozlabs.org>
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

This is better posted to the u-boot-users list=20
(u-boot-users@lists.sourceforge.net)

- kumar

On Mar 4, 2005, at 9:53 AM, Jaka Mo=C4=8Dnik wrote:

> hello!
>
> I don't really know if this mailing list is the proper place to direct
>  questions regarding U-Boot, but I've seen some preceding posts about=20=

> it,
>  so I thought I'd ask...
>
> I've ported U-Boot over to a custom MPC8560 (PQ3) based board - it=20
> works
> well, except that after a sw reboot (from linux kernel or u-boot
>  itself), it only gets to the part where it relocates itself to RAM =
and
>  then hangs - the last debug output is
>
>  Relocating code to 07fd4000...
>
> and the famous
>
> Now running in RAM - U-Boot at: 07fd4000 never shows up.
>
> has anyone experienced similar problems? any hints on what to look at?
>
> regards,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 jaKa
>
> --=20
>
>  w3: http://fish.homeunix.org/people/jaka
> email: jaka@activetools.si
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
