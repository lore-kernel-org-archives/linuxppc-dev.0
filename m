Return-Path: <sumedhtirodkar@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 51B55DE172
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 16:32:00 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so7802757wfg.15
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Jan 2009 21:31:59 -0800 (PST)
Message-ID: <d2b9ccd90901042131v2b00bd0bld7009e8d865bd9c7@mail.gmail.com>
Date: Mon, 5 Jan 2009 11:01:58 +0530
From: "sumedh tirodkar" <sumedhtirodkar@gmail.com>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: yaboot: text mode or graphics mode?
In-Reply-To: <495AA4A7.409@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <d2b9ccd90812200807k59ae3b30j832ad752f297d350@mail.gmail.com>
	<d2b9ccd90812200956jee5279ak68776aec20fb8b80@mail.gmail.com>
	<495AA4A7.409@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Isn't there any other way that i can access the VGA registers? So as
to reconfigure them...

-Sumedh

On Wed, Dec 31, 2008 at 4:15 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> sumedh tirodkar wrote:
>>
>> I just found out that openfirmware boots into graphics mode(non-text
>> mode). Now i wish to switch back to text mode. how do i do this?
>
> Unfortunately unless you are running some kind of yaboot-accessible or
> firmware-accessible x86 BIOS emulation, this isn't possible.
>
> --
> Matt
>
