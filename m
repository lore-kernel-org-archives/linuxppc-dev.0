Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f199.google.com (mail-yw0-f199.google.com
	[209.85.211.199]) by ozlabs.org (Postfix) with ESMTP id 17BAFB7B7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 05:21:49 +1100 (EST)
Received: by ywh37 with SMTP id 37so52514ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 11:21:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <6E9D235B18CE694399D781F05D9C42E7A035ADDD@SI-MBX11.de.bosch.com>
References: <6E9D235B18CE694399D781F05D9C42E7A035ADDD@SI-MBX11.de.bosch.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 14 Oct 2009 12:21:27 -0600
Message-ID: <fa686aa40910141121r74ea411dwd602685a98eb31a5@mail.gmail.com>
Subject: Re: MPC5200B and USB
To: "FIXED-TERM Seeh Thomas (BEG/EMS1)" <fixed-term.Thomas.Seeh@de.bosch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2009 at 6:57 AM, FIXED-TERM Seeh Thomas (BEG/EMS1)
<fixed-term.Thomas.Seeh@de.bosch.com> wrote:
> Hello everyone,
>
> I'm working on a project to get USB ready on a MPC5200B based board.
> On this board I'm not using Linux (but MQX), but my question is not related
> to Linux.
> It's more specific to USB and OHCI.
> I will communicate with a Mass Storage Device and therefor the control
> transfer works fine.
> The Mass Storage Device has two endpoints for bulk transfer, one IN (from
> device to host) and
> one OUT (from host to device).
>
> If I want to communicate with the device should I have two endpoints on the
> host side too?

Sounds like you need to brush up on how USB works.  The host
controller can talk to any endpoint on any device, and it schedules
the transfers for them.  There are no host-side endpoints like there
are on the device.

This question is very off-topic for this list.  You should refer to
the USB standards documentation or look for a USB specific mailing
list.  Please don't ask non-Linux questions on a Linux mailing list.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
