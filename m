Return-Path: <sumedhtirodkar@gmail.com>
Received: from mail-bw0-f10.google.com (mail-bw0-f10.google.com
	[209.85.218.10]) by ozlabs.org (Postfix) with ESMTP id B5358DDEF0
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Dec 2008 04:56:57 +1100 (EST)
Received: by bwz3 with SMTP id 3so3688285bwz.9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Dec 2008 09:56:54 -0800 (PST)
Message-ID: <d2b9ccd90812200956jee5279ak68776aec20fb8b80@mail.gmail.com>
Date: Sat, 20 Dec 2008 23:26:54 +0530
From: "sumedh tirodkar" <sumedhtirodkar@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: yaboot: text mode or graphics mode?
In-Reply-To: <d2b9ccd90812200807k59ae3b30j832ad752f297d350@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <d2b9ccd90812200807k59ae3b30j832ad752f297d350@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I just found out that openfirmware boots into graphics mode(non-text
mode). Now i wish to switch back to text mode. how do i do this?

On Sat, Dec 20, 2008 at 9:37 PM, sumedh tirodkar
<sumedhtirodkar@gmail.com> wrote:
> Does anyone knw what happens when we boot into yaboot,whether we are
> in text mode or graphics mode? If text mode then wat is the address of
> the screen? I need it to print some debug info..bt i either dnt seem
> to get the buffer address correct or i m not in text mode as yaboot
> has already switched to some other mode...
>
> Regards,
> Sumedh
>
