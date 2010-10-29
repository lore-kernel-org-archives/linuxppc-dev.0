Return-Path: <baringforge@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id 67BCAB70CD
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 30 Oct 2010 07:11:59 +1100 (EST)
Received: by fxm1 with SMTP id 1so3446829fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 13:11:56 -0700 (PDT)
MIME-Version: 1.0
Sender: baringforge@gmail.com
In-Reply-To: <4CCA9207.8050506@neli.hopto.org>
References: <AANLkTimS-sfqONuSJNPJy7OxO_U81qtDHe2JeioLDNVs@mail.gmail.com>
	<4CCA9207.8050506@neli.hopto.org>
From: Thomas Taranowski <tom@baringforge.com>
Date: Fri, 29 Oct 2010 13:11:36 -0700
Message-ID: <AANLkTikhcOMexRBVthK8Xr8VTNvDmiUDvWG+QbyzWc38@mail.gmail.com>
Subject: Re: RapidIO: MC Exception when enumerating peer to peer connection
To: Micha Nelissen <micha@neli.hopto.org>
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

Yes, I tried pretty much all combinations of boot order, but I believe
the preferred approach is to boot the agents first, then the host
according to my freescale documentation.  My problem was that all
three devices had the same device id.  Once I programmed them with
different device id's via the alternate device id register I could
finally get doorbell messages across with the jtag.

Thanks


On Fri, Oct 29, 2010 at 2:21 AM, Micha Nelissen <micha@neli.hopto.org> wrote:
> Thomas Taranowski wrote:
>>
>> use my trusty jtag to issue a Port Link Maintenance Request and
>> request status, I get back unrecoverable ackID error for port 1, and
>> error-stopped port_status for port 2.
>
> Did you try rebooting all devices together?
>
> Micha
>
