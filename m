Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D97EFB6F8C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2011 17:34:10 +1100 (EST)
Received: by vws20 with SMTP id 20so1018007vws.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 23:34:07 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <2DD52030B5146141BEB762A11AE97C4CF6E5E9@SPQCEXC05.exfo.com>
References: <2DD52030B5146141BEB762A11AE97C4CF6E0ED@SPQCEXC05.exfo.com>
 <CAAXf6LXuid9NJcY9DeJYJR0ns6corATzxN2BN5RpkGE08OVcQw@mail.gmail.com>
 <2DD52030B5146141BEB762A11AE97C4CF6E2E7@SPQCEXC05.exfo.com>
 <CAAXf6LWTU_OVBLfn4Tavo6JxE5UfoN8JuCidB4fbr4-RX+XdAw@mail.gmail.com>
 <2DD52030B5146141BEB762A11AE97C4CF6E5E9@SPQCEXC05.exfo.com>
Date: Wed, 19 Oct 2011 08:34:07 +0200
Message-ID: <CAAXf6LVketwJhnvRBq7ftpxq912MV8RgUoFoVyUv5G8Xtv7MpQ@mail.gmail.com>
Subject: Re: FW: P4080 device tree problems with fsl dpaa ... RESOLVED.
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: Robert Sciuk <robert.sciuk@exfo.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Robert,

On Tue, Oct 18, 2011 at 11:38 PM, Robert Sciuk <robert.sciuk@exfo.com> wrot=
e:
>
>
> [snip]
>
>>
>> How and what type of packets are you sending? Raw MAC frames, IP? Are
>> you using custom code, or can you try things like ping?
>> If you are using IP, I trust you checked the Linux configuration (like
>> assigning a valid IP address to the interface and making sure the
>> routing table is correct).
>>
>> Best regards,
>> Thomas
>
> Thomas,
>
> I would like to thank you for your very kind assistance on the DPAA probl=
em. =A0We traced the problem to the connection between MAC and PHY, and we =
have resolved it by instrumenting code and comparing the TBI and PHY initia=
lization from u-boot to the Linux DPA code, and replacing some of the "magi=
c numbers" we found in the driver with "magic numbers" we know to work. =A0=
OUCH!
>
> We spent an inordinate amount of effort in trying to understand the undoc=
umented code/tree, but I am convinced that the device-tree approach to embe=
dded boards is a very valuable approach, and will ultimately solve many mor=
e problems than it creates short term.
>
> Again, your information was of great assistance, and I look forward to be=
ing able to pay forward the same kind of assistance in the future.

I'm very glad you found the issue (I was running out of ideas ;-) and
that I was able to help you in some way.
Thanks for posting back.

Good luck with the rest of your project!

Best regards,
Thomas

>
> Cheers,
> Rob Sciuk.
>
>
