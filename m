Return-Path: <leon.woestenberg@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id D12F5DDF91
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 21:07:27 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so367859ywh.39
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 04:07:26 -0700 (PDT)
Message-ID: <c384c5ea0809300407o637814e7kfc94e6fb01479902@mail.gmail.com>
Date: Tue, 30 Sep 2008 13:07:26 +0200
From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
To: "=?ISO-8859-1?Q?Andr=E9_Schwarz?=" <Andre.Schwarz@matrix-vision.de>,
	linuxppc-dev@ozlabs.org
Subject: Re: How to prevent embedded ppc reset deadlock? (MPC83xx/85xx)
In-Reply-To: <c384c5ea0809291505p5a12f5aerd48515cb5c305155@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c384c5ea0809291433j10619a49xe713415f6bb90204@mail.gmail.com>
	<48E14DAE.9040101@matrix-vision.de>
	<c384c5ea0809291505p5a12f5aerd48515cb5c305155@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andr=E9,

On Tue, Sep 30, 2008 at 12:05 AM, Leon Woestenberg
<leon.woestenberg@gmail.com> wrote:
>> Since you also have to assert HRESET when you assert PORESET
>>
> But when I assert PORESET, the processor will assert HRESET itself
> AFAIK, so why do this?
>
>> you can wire-or them with a low drop schottky diode.
>>

MPC8313E PowerQUICC II Pro Integrated Processor Family Reference
Manual, Rev. 1, section 4.2.2, page 4-6:

"Directly after the negation of PORESET, the device starts the
configuration process. The device asserts HRESET throughout the
power-on reset process, including configuration"

So, I will not drive HRESET myself but depend on the ppc to drive it for me=
.

Regards,
--=20
Leon
