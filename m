Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.mud.yahoo.com (smtp103.biz.mail.mud.yahoo.com
	[68.142.200.238]) by ozlabs.org (Postfix) with SMTP id 9E63F683EA
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Oct 2005 02:04:58 +1000 (EST)
In-Reply-To: <43423996.7090403@iki.fi>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
	<20050930142218.348041d6.ajz@cambridgebroadband.com>
	<2c578118c5d984e6e87ac3c073469866@embeddededge.com>
	<433D9BCE.5000909@iki.fi>
	<6eac69d46b656d812783d81a6ebeac84@embeddededge.com>
	<433E2530.7090503@iki.fi>
	<26a6f673ac9438729eccfe0c376c6b3d@embeddedalley.com>
	<4340D7EF.2040709@iki.fi> <43423996.7090403@iki.fi>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <78dde895f83bb5b18bc62915a3e0c563@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Date: Tue, 4 Oct 2005 09:04:56 -0700
To: Kalle Pokki <kalle.pokki@iki.fi>
Cc: linuxppc-embedded@ozlabs.org
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


On Oct 4, 2005, at 1:13 AM, Kalle Pokki wrote:

> ...... This errata should probably be included in the Linux kernel, 
> since it really depends on it.

Everything depends on that, and it should be done in the boot rom as
part of the processor initialization after reset.

Thanks.

	-- Dan
