Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id 6E901DDE41
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 04:11:19 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so492158anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 09:11:18 -0800 (PST)
Message-ID: <fa686aa40801210911q4ce90816tebafa46e68a3f980@mail.gmail.com>
Date: Mon, 21 Jan 2008 10:11:18 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [patch v4 0/4] Cypress c67x00 (EZ-Host/EZ-OTG) support
In-Reply-To: <20080121103434.397382000@sunsite.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080121103434.397382000@sunsite.dk>
Cc: linuxppc-dev@ozlabs.org, dbrownell@users.sourceforge.net,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/21/08, Peter Korsgaard <jacmet@sunsite.dk> wrote:
> The Cypress c67x00 (EZ-Host/EZ-OTG) controllers are multi-role low/fullspeed
> USB controllers. This patch series implements a HCD driver and shows the
> work-in-progress status of a gadget driver.
>
> I believe patch 1..3 are ready, and I would like to see queued up for 2.6.25.
>
> Changes since v3:
> - Lots of cleanups: checkpatch, interrupt handling, c67x00_ prefixes, ..
> - The dummy platform_device's created per serial engine are gone.
> - Gadget driver (WIP)

Can you please post/publish the diff between v3 and this series?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
