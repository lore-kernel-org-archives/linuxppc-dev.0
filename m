Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 16B02DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 02:59:35 +1000 (EST)
Message-ID: <470A61B1.2060705@ru.mvista.com>
Date: Mon, 08 Oct 2007 20:58:25 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [linux-usb-devel] [PATCH] USB: Add frame_no big endian OHCI quirk.
References: <20071008165436.GA19653@ru.mvista.com>
In-Reply-To: <20071008165436.GA19653@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: david-b@pacbell.net, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've tested this patch only on PowerPC 440EPx Sequoia.
So, this needs to be tested at least on mpc52xx.
Thanks,
Valentine.
