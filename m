Return-Path: <glikely@secretlab.ca>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 9618BB7D67
	for <linuxppc-dev@ozlabs.org>; Tue, 11 May 2010 06:46:26 +1000 (EST)
Received: by gwb11 with SMTP id 11so936350gwb.15
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 13:46:24 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100510162535.GA15137@suse.de>
References: <g2xc2d0b6ec1005041339r9c40822w7a642f9bba976820@mail.gmail.com>
	<1273011539-13994-1-git-send-email-agust@denx.de>
	<i2xfa686aa41005091504ve2b35a09m23cd2dc13a331f86@mail.gmail.com>
	<20100510162535.GA15137@suse.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 10 May 2010 22:46:02 +0200
Message-ID: <AANLkTikQtzUatwiVjZmsMSFRf_MLsffir6N4tNCMSex7@mail.gmail.com>
Subject: Re: [PATCH] serial: mpc52xx_uart: fix null pointer dereference
To: Greg KH <gregkh@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, leonardo.lists@gmail.com,
	Anatolij Gustschin <agust@denx.de>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 10, 2010 at 6:25 PM, Greg KH <gregkh@suse.de> wrote:
> On Mon, May 10, 2010 at 12:04:30AM +0200, Grant Likely wrote:
>> Greg, I can either pick this up and push it out to Linus tomorrow, or
>> let you do it. =A0Whichever you prefer. =A0Let me know so I don't cause
>> conflicts in your tree.
>
> I have 2 other tty/serial fixes to go to Linus for .34 along with this
> one, so I'll be glad to send it to him. =A0I've added your ack to the
> patch.

Perfect.  Thanks Greg.

g.
