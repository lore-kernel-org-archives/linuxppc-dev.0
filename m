Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 39590683E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 00:11:52 +1000 (EST)
Received: from [194.100.64.94] (host94.eke.fi [194.100.64.94])
	by smtp2.song.fi (Postfix) with ESMTP id 36D594DCCC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Sep 2005 17:11:46 +0300 (EEST)
Message-ID: <43395322.1080407@iki.fi>
Date: Tue, 27 Sep 2005 16:11:46 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi>
In-Reply-To: <4333DF04.3000908@iki.fi>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is the alloc_bootmem() function in e.g. cpm_uart_allocbuf() supposed to 
give non-cached memory? In my 8248 board it seems not to. Only using 
DPRAM as buffer storage allows booting to proceed without hanging right 
in the beginning.

Any ideas what can set the bootmem memory as cached?
