Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 451EC683A8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 06:48:15 +1000 (EST)
In-Reply-To: <4339AD01.30708@iki.fi>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Date: Tue, 27 Sep 2005 16:48:21 -0400
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


On Sep 27, 2005, at 4:35 PM, Kalle Pokki wrote:

> OK. Then the question really is why isn't the cache controller 
> enforcing coherency between the G2_LE core and the CPM.

Is the GBL and DTB set properly in the function code registers
of the SCC parameter ram?


	-- Dan
