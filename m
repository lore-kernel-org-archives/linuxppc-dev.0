Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id ABCD5DDDED
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 02:25:53 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so37666rvb.9
	for <linuxppc-dev@ozlabs.org>; Fri, 05 Dec 2008 07:25:51 -0800 (PST)
Message-ID: <fa686aa40812050725v7b6d5c8axc5a2aabec18c6e83@mail.gmail.com>
Date: Fri, 5 Dec 2008 08:25:51 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: gianfranco.casanova@alice.it
Subject: Re: R: usb/eth DTS nodes for custom board based on mpc5200
In-Reply-To: <47602D18F269934AB73B7E550804A1E002137987@FBCMST09V03.fbc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <504269.31435.qm@web23108.mail.ird.yahoo.com>
	<fa686aa40812050640m4b4afe2egef638ca950cff041@mail.gmail.com>
	<47602D18F269934AB73B7E550804A1E002137987@FBCMST09V03.fbc.local>
Cc: s104259@yahoo.it, devicetree-discuss@ozlabs.org,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 5, 2008 at 8:16 AM,  <gianfranco.casanova@alice.it> wrote:
> Hi Grant
>
> we have already tested what you are suggesting, but nothing happens.
>
> I'm supposing the problem comes from interrupts.

Unlikely.  The interrupt routing is hard wired into the SoC and
probably not messed up (unless the USB node in the device tree has
been changed).  You may have a problem with port_config (setup for
single ended vs differential signaling) or some other electrical
difference from the 5200.  Beyond that it's not something that is easy
to figure out over email.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
