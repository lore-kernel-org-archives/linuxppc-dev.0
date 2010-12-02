Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id 4C7CEB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Dec 2010 03:18:04 +1100 (EST)
Received: by iwn5 with SMTP id 5so1452944iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 02 Dec 2010 08:18:02 -0800 (PST)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <201012021636.05963.dargaud@lpsc.in2p3.fr>
References: <201012011115.00960.dargaud@lpsc.in2p3.fr>
	<201012011735.58769.dargaud@lpsc.in2p3.fr>
	<20101201124142.15f75af7@udp111988uds.am.freescale.net>
	<201012021636.05963.dargaud@lpsc.in2p3.fr>
From: Timur Tabi <timur@freescale.com>
Date: Thu, 2 Dec 2010 10:17:32 -0600
Message-ID: <AANLkTinnXoU2kPEB-OmDWoWom18Nu9r0jOT==zWmRp4k@mail.gmail.com>
Subject: Re: Getting the IRQ number (Was: Basic driver devel questions ?)
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
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

On Thu, Dec 2, 2010 at 9:36 AM, Guillaume Dargaud <dargaud@lpsc.in2p3.fr> wrote:

> Sounds like what I need... But I don't find irq_of_parse_and_map() in LDD 3rd
> ed and very few info in google. Are there some examples of use somewhere ?

     grep -r irq_of_parse_and_map *

will give you plenty of examples.

-- 
Timur Tabi
Linux kernel developer at Freescale
