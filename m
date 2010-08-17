Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.176])
	by ozlabs.org (Postfix) with ESMTP id CE76AB70AE
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 17:12:41 +1000 (EST)
Message-ID: <4C6A3665.7030207@neli.hopto.org>
Date: Tue, 17 Aug 2010 09:12:37 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Subject: Re: [PATCH 2/9] RapidIO, powerpc/85xx: modify RIO port-write interrupt
	handler
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-3-git-send-email-alexandre.bounine@idt.com>
	<4C692B42.9050407@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F94@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F94@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bounine, Alexandre wrote:
> capable to receive and keep only one PW message. Therefore, I copy it
> into the driver's FIFO and re-enable HW Rx queue (it is called queue but
> can accept only one entry) ASAP. I have a test setup that is capable
> generate multiple PW messages and see many messages discarded by PW
> controller because of this single-entry HW queue.

Primarily due to the single entry queue, the order of checking is 
probably insignificant? :-) Anyway, I don't mind changing the order.

Micha
