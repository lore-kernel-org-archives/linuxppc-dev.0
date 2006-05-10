Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3AA62679F9
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 21:25:43 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 4DB171EBDD
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 13:25:38 +0200 (CEST)
Date: Wed, 10 May 2006 13:25:38 +0200
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Failed to do bolted mapping IO memory with minimal .config
Message-ID: <20060510112537.GA15995@suse.de>
References: <20060510095943.GA15460@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060510095943.GA15460@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, May 10, Olaf Hering wrote:

> CONFIG_NR_CPUS=4

It boots if I change this to 8.
