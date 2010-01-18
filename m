Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f198.google.com (mail-yw0-f198.google.com
	[209.85.211.198]) by ozlabs.org (Postfix) with ESMTP id A5E2CB7C9D
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 04:40:05 +1100 (EST)
Received: by ywh36 with SMTP id 36so2730296ywh.15
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jan 2010 09:40:03 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B503422.60209@monstr.eu>
References: <4B4DE58D.10008@petalogix.com> <1263434836.724.317.camel@pasglop>
	<4B503422.60209@monstr.eu>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 18 Jan 2010 10:39:43 -0700
Message-ID: <fa686aa41001180939m7a1f60eat208e548911c3c7a5@mail.gmail.com>
Subject: Re: xilinx-pci driver and pci in general
To: monstr@monstr.eu
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, michal.simek@petalogix.com,
	thunderbird2k@gmx.net, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 15, 2010 at 2:23 AM, Michal Simek <monstr@monstr.eu> wrote:
> Benjamin Herrenschmidt wrote:
>> On Wed, 2010-01-13 at 16:23 +0100, Michal Simek wrote:
>>> Thanks for this early discuss. I would like to hear your opinion and then
>>> I will choose solution how to add our pci support to mainline.
>
> I will keep you informed but I see that I will add that part of code to
> mainline and then we look at consolidation work.

As mentioned in previous email, please do it the other way around.  It
may seem like more work to do so, but it is less work in the long
term.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
