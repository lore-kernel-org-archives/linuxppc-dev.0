Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id E8238DE3B9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jul 2008 03:37:10 +1000 (EST)
Date: Mon, 21 Jul 2008 13:37:11 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: Networkl problems with lastest kernel....
Message-ID: <20080721133711.43c146f2@lappy.seanm.ca>
In-Reply-To: <20080721.101650.181903456.davem@davemloft.net>
References: <20080721121829.28faffab@lappy.seanm.ca>
	<20080721.093110.141511905.davem@davemloft.net>
	<20080721130536.3ca72f3e@lappy.seanm.ca>
	<20080721.101650.181903456.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Jul 2008 10:16:50 -0700 (PDT)
"David Miller" <davem@davemloft.net> wrote:

> The same problem is still there, this driver will
> unfortunately require quite a bit more surgery.
> 
> You can instead add the following patch, it will
> warn instead of BUG on you, and try to continue.

Ok, that lets me boot. Thanks.

Cheers,
   Sean
