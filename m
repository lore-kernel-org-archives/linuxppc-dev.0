Return-Path: <slightlyunconventional@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7FACAB6F2B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Mar 2011 10:48:11 +1100 (EST)
Received: by gyb11 with SMTP id 11so2629425gyb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Mar 2011 16:48:07 -0700 (PDT)
MIME-Version: 1.0
Sender: slightlyunconventional@gmail.com
In-Reply-To: <1300427072.22236.1277.camel@pasglop>
References: <1300427072.22236.1277.camel@pasglop>
Date: Fri, 18 Mar 2011 16:48:06 -0700
Message-ID: <AANLkTi=FJaapiP+ujJezePD33UxYm0nVVtL9_tR9UoKf@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Hollis Blanchard <hollis@penguinppc.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: meador_inge@mentor.com, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 17, 2011 at 10:44 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> Hi Linus !
>
> Here are the changes for this merge window for powerpc. One highlight
> is irq data conversion so we can get rid of the legacy stuff. The new
> Dynamic DMA windows for pSeries should also improve performances for
> some devices nicely on more recent machines/firmwares. Plus a little
> pack of embedded things.

Ben, you missed the patches from Meador:

http://patchwork.ozlabs.org/patch/86804/
http://patchwork.ozlabs.org/patch/86805/
http://patchwork.ozlabs.org/patch/86806/

Please commit.

-Hollis
