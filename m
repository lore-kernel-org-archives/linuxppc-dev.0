Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 915C6DDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Mar 2008 15:47:56 +1100 (EST)
Date: Tue, 25 Mar 2008 00:47:53 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RESEND] [PATCH 1/2 v2] [OF] Add of_device_is_available function
Message-ID: <20080325004753.5885ede9@lappy.seanm.ca>
In-Reply-To: <18407.37606.990271.551578@cargo.ozlabs.ibm.com>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301174825.57715d46@zod.rchland.ibm.com>
	<18407.37606.990271.551578@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 24 Mar 2008 22:39:18 +1100
"Paul Mackerras" <paulus@samba.org> wrote:

> The second test will succeed for anything that starts with "ok", so
> the first test is redundant.  I suspect you want strcmp instead of
> strncmp in both tests.

I like the strncmp(status, "ok", 2). Then you can have a status of
okey-dokey ;)

Cheers,
   Sean
