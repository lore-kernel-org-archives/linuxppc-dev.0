Return-Path: <neko@genesi-usa.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.185])
	by ozlabs.org (Postfix) with ESMTP id A0493DDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Dec 2008 09:46:00 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so4168586rnf.16
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Dec 2008 14:45:58 -0800 (PST)
Sender: Matt Sealey <neko@genesi-usa.com>
Message-ID: <495AA4A7.409@genesi-usa.com>
Date: Tue, 30 Dec 2008 16:45:59 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: sumedh tirodkar <sumedhtirodkar@gmail.com>
Subject: Re: yaboot: text mode or graphics mode?
References: <d2b9ccd90812200807k59ae3b30j832ad752f297d350@mail.gmail.com>
	<d2b9ccd90812200956jee5279ak68776aec20fb8b80@mail.gmail.com>
In-Reply-To: <d2b9ccd90812200956jee5279ak68776aec20fb8b80@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

sumedh tirodkar wrote:
> I just found out that openfirmware boots into graphics mode(non-text
> mode). Now i wish to switch back to text mode. how do i do this?

Unfortunately unless you are running some kind of yaboot-accessible or 
firmware-accessible x86 BIOS emulation, this isn't possible.

--
Matt
